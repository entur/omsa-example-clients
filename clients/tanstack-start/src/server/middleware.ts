import { createMiddleware } from "@tanstack/react-start";
import { getAccessToken } from "./auth";

export const authMiddleware = createMiddleware({ type: "function" }).server(
	async ({ next }) => {
		await getAccessToken();
		return next();
	},
);
