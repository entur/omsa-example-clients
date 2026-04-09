import { afterEach, describe, expect, it } from "vitest";
import { getRuntimeConfig } from "./runtime-config";

const ORIGINAL_ENV = { ...process.env };

function resetRuntimeEnv() {
	process.env = { ...ORIGINAL_ENV };
	delete process.env.OMSA_ENV_MODE;
	delete process.env.OMSA_CREDENTIAL_PROFILE;
	delete process.env.OMSA_BASE_URL;
	delete process.env.SALES_BASE_URL;
	delete process.env.OAUTH_TOKEN_URL;
	delete process.env.AUTH0_AUDIENCE;
	delete process.env.CLIENT_ID;
	delete process.env.CLIENT_SECRET;
	delete process.env.CLIENT_ID_DEV;
	delete process.env.CLIENT_SECRET_DEV;
	delete process.env.CLIENT_ID_STAGING;
	delete process.env.CLIENT_SECRET_STAGING;
}

afterEach(() => {
	resetRuntimeEnv();
});

describe("getRuntimeConfig", () => {
	it("uses dev OAuth defaults in dev mode", () => {
		process.env.OMSA_ENV_MODE = "dev";

		const config = getRuntimeConfig();

		expect(config.oauthTokenUrl).toBe("https://partner.dev.entur.org/oauth/token");
		expect(config.auth0Audience).toBe("https://api.dev.entur.io");
		expect(config.salesBaseUrl).toBe("https://api.dev.entur.io/sales/v1");
		expect(config.credentialProfile).toBe("dev");
	});

	it("uses staging OAuth defaults in staging mode", () => {
		process.env.OMSA_ENV_MODE = "staging";

		const config = getRuntimeConfig();

		expect(config.oauthTokenUrl).toBe(
			"https://partner.staging.entur.org/oauth/token",
		);
		expect(config.auth0Audience).toBe("https://api.staging.entur.io");
		expect(config.salesBaseUrl).toBe("https://api.staging.entur.io/sales/v1");
		expect(config.credentialProfile).toBe("staging");
	});

	it("uses staging OAuth defaults in local-tst mode while keeping OMSA local", () => {
		process.env.OMSA_ENV_MODE = "local-tst";

		const config = getRuntimeConfig();

		expect(config.omsaBaseUrl).toBe("http://localhost:8080/v1");
		expect(config.oauthTokenUrl).toBe(
			"https://partner.staging.entur.org/oauth/token",
		);
		expect(config.auth0Audience).toBe("https://api.staging.entur.io");
		expect(config.salesBaseUrl).toBe("https://api.staging.entur.io/sales/v1");
		expect(config.credentialProfile).toBe("staging");
	});
});
