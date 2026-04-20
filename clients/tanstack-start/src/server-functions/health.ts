import { createServerFn } from "@tanstack/react-start";
import { omsa } from "../server/omsa-client";

export const checkHealth = createServerFn({ method: "GET" }).handler(
	async () => {
		return omsa.get<Record<string, string>>("/health");
	},
);
