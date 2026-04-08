import { getAccessToken } from "./auth";

function getBaseUrl(): string {
	return (
		process.env.OMSA_BASE_URL ?? "https://api.dev.entur.io/omsa/v1"
	).replace(/\/$/, "");
}

function getSalesBaseUrl(): string {
	return (
		process.env.SALES_BASE_URL ?? "https://api.dev.entur.io/sales/v1"
	).replace(/\/$/, "");
}

function enturHeaders(): Record<string, string> {
	return {
		"Entur-Distribution-Channel":
			process.env.ENTUR_DISTRIBUTION_CHANNEL ?? "KOL:DistributionChannel:App",
		"Et-Client-Name": process.env.ET_CLIENT_NAME ?? "omsa",
		"Entur-POS": process.env.ENTUR_POS ?? "Kolumbus",
	};
}

async function authorizedHeaders(): Promise<Record<string, string>> {
	const authorization = await getAccessToken();
	return {
		Authorization: authorization,
		Accept: "application/json",
		"Accept-Language": "en-GB",
		...enturHeaders(),
	};
}

async function handleResponse<T>(
	response: Response,
	action: string,
): Promise<T> {
	if (!response.ok) {
		const text = await response.text();
		throw new Error(`OMSA ${action} failed (${response.status}): ${text}`);
	}
	return response.json() as Promise<T>;
}

export const omsa = {
	async get<T>(path: string, params?: Record<string, string>): Promise<T> {
		const url = new URL(`${getBaseUrl()}${path}`);
		if (params) {
			for (const [key, value] of Object.entries(params)) {
				url.searchParams.set(key, value);
			}
		}
		const response = await fetch(url.toString(), {
			headers: await authorizedHeaders(),
		});
		return handleResponse<T>(response, `GET ${path}`);
	},

	async post<T>(path: string, body: unknown): Promise<T> {
		const response = await fetch(`${getBaseUrl()}${path}`, {
			method: "POST",
			headers: {
				...(await authorizedHeaders()),
				"Content-Type": "application/json",
			},
			body: JSON.stringify(body),
		});
		return handleResponse<T>(response, `POST ${path}`);
	},
};

export const sales = {
	async post<T>(path: string, body: unknown): Promise<T> {
		const authorization = await getAccessToken();
		const response = await fetch(`${getSalesBaseUrl()}${path}`, {
			method: "POST",
			headers: {
				Authorization: authorization,
				Accept: "application/hal+json",
				"Accept-Language": "en-GB",
				"Content-Type": "application/json",
				...enturHeaders(),
			},
			body: JSON.stringify(body),
		});
		return handleResponse<T>(response, `POST ${path}`);
	},

	async put<T>(path: string): Promise<T> {
		const authorization = await getAccessToken();
		const response = await fetch(`${getSalesBaseUrl()}${path}`, {
			method: "PUT",
			headers: {
				Authorization: authorization,
				Accept: "application/hal+json",
				"Accept-Language": "en-GB",
				...enturHeaders(),
			},
		});
		return handleResponse<T>(response, `PUT ${path}`);
	},

	async get<T>(path: string): Promise<T> {
		const authorization = await getAccessToken();
		const response = await fetch(`${getSalesBaseUrl()}${path}`, {
			headers: {
				Authorization: authorization,
				Accept: "application/hal+json",
				"Accept-Language": "en-GB",
				...enturHeaders(),
			},
		});
		return handleResponse<T>(response, `GET ${path}`);
	},
};
