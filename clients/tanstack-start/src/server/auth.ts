interface OAuthToken {
	accessToken: string;
	tokenType: string;
	expiresAt: number;
}

let cachedToken: OAuthToken | null = null;

function isExpired(token: OAuthToken): boolean {
	const safetyWindowMs = 5 * 60 * 1000;
	return Date.now() >= token.expiresAt - safetyWindowMs;
}

export async function getAccessToken(): Promise<string> {
	if (cachedToken && !isExpired(cachedToken)) {
		return `${cachedToken.tokenType} ${cachedToken.accessToken}`;
	}

	const tokenUrl = process.env.OAUTH_TOKEN_URL;
	const clientId = process.env.CLIENT_ID;
	const clientSecret = process.env.CLIENT_SECRET;
	const audience = process.env.AUTH0_AUDIENCE;

	if (!tokenUrl || !clientId || !clientSecret) {
		throw new Error(
			"OAuth credentials not configured. Set OAUTH_TOKEN_URL, CLIENT_ID, and CLIENT_SECRET.",
		);
	}

	const response = await fetch(tokenUrl, {
		method: "POST",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/x-www-form-urlencoded",
		},
		body: new URLSearchParams({
			grant_type: "client_credentials",
			client_id: clientId,
			client_secret: clientSecret,
			...(audience ? { audience } : {}),
		}),
	});

	if (!response.ok) {
		const text = await response.text();
		throw new Error(`OAuth token request failed (${response.status}): ${text}`);
	}

	const body = await response.json();
	const expiresIn = Number(body.expires_in ?? 3600);

	cachedToken = {
		accessToken: body.access_token,
		tokenType: body.token_type ?? "Bearer",
		expiresAt: Date.now() + expiresIn * 1000,
	};

	return `${cachedToken.tokenType} ${cachedToken.accessToken}`;
}
