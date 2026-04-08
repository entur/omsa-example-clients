import { useMutation } from "@tanstack/react-query";
import {
	cancelPackage,
	claimRefund,
	confirmPackage,
	purchaseOffers,
} from "../server-functions/purchase";
import type {
	CancelPackageRequest,
	ClaimRefundRequest,
	ConfirmedPackage,
	ConfirmPackageRequest,
	PurchaseOffersRequest,
} from "../types/purchase";

export function usePurchaseOffers() {
	return useMutation<ConfirmedPackage, Error, PurchaseOffersRequest>({
		mutationFn: (req) =>
			purchaseOffers({ data: req }) as Promise<ConfirmedPackage>,
	});
}

export function useConfirmPackage() {
	return useMutation<ConfirmedPackage, Error, ConfirmPackageRequest>({
		mutationFn: (req) =>
			confirmPackage({ data: req }) as Promise<ConfirmedPackage>,
	});
}

export function useCancelPackage() {
	return useMutation<ConfirmedPackage, Error, CancelPackageRequest>({
		mutationFn: (req) =>
			cancelPackage({ data: req }) as Promise<ConfirmedPackage>,
	});
}

export function useClaimRefund() {
	return useMutation<Record<string, unknown>, Error, ClaimRefundRequest>({
		mutationFn: (req) =>
			claimRefund({ data: req }) as Promise<Record<string, unknown>>,
	});
}
