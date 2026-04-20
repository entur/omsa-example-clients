import { createServerFn } from "@tanstack/react-start";
import { authMiddleware } from "../server/middleware";
import { omsa } from "../server/omsa-client";
import type { OfferCollection, SearchOfferRequest } from "../types/search";

export const searchOffers = createServerFn({ method: "POST" })
	.middleware([authMiddleware])
	.inputValidator((data: SearchOfferRequest) => data)
	.handler(async ({ data }) => {
		return omsa.post<OfferCollection>("/processes/search-offers/execute", data);
	});
