import { createServerFn } from "@tanstack/react-start";
import { authMiddleware } from "../server/middleware";
import { omsa } from "../server/omsa-client";
import type {
	ChangeOptionCollection,
	RefundOptionCollection,
	TravelDocumentCollection,
} from "../types/documents";

export const getTravelDocuments = createServerFn({ method: "GET" })
	.middleware([authMiddleware])
	.inputValidator((packageId: string) => packageId)
	.handler(async ({ data: packageId }) => {
		return omsa.get<TravelDocumentCollection>(
			"/collections/travel-documents/items",
			{ packageId },
		);
	});

export const getRefundOptions = createServerFn({ method: "GET" })
	.middleware([authMiddleware])
	.inputValidator((packageId: string) => packageId)
	.handler(async ({ data: packageId }) => {
		return omsa.get<RefundOptionCollection>(
			"/collections/refund-options/items",
			{ packageId },
		);
	});

export const getChangeOptions = createServerFn({ method: "GET" })
	.middleware([authMiddleware])
	.inputValidator((packageId: string) => packageId)
	.handler(async ({ data: packageId }) => {
		return omsa.get<ChangeOptionCollection>(
			"/collections/change-options/items",
			{ packageId },
		);
	});
