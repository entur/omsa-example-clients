import { useQuery } from "@tanstack/react-query";
import {
	getChangeOptions,
	getRefundOptions,
	getTravelDocuments,
} from "../server-functions/documents";
import type {
	ChangeOptionCollection,
	RefundOptionCollection,
	TravelDocumentCollection,
} from "../types/documents";

export function useTravelDocuments(packageId: string | null) {
	return useQuery<TravelDocumentCollection>({
		queryKey: ["travel-documents", packageId],
		queryFn: () => getTravelDocuments({ data: packageId ?? "" }),
		enabled: !!packageId,
		staleTime: 60_000,
	});
}

export function useRefundOptions(packageId: string | null) {
	return useQuery<RefundOptionCollection>({
		queryKey: ["refund-options", packageId],
		queryFn: () => getRefundOptions({ data: packageId ?? "" }),
		enabled: !!packageId,
		staleTime: 30_000,
	});
}

export function useChangeOptions(packageId: string | null) {
	return useQuery<ChangeOptionCollection>({
		queryKey: ["change-options", packageId],
		queryFn: () => getChangeOptions({ data: packageId ?? "" }),
		enabled: !!packageId,
		staleTime: 30_000,
	});
}
