import { useMutation } from "@tanstack/react-query";
import { searchOffers } from "../server-functions/search";
import type { OfferCollection, SearchOfferRequest } from "../types/search";

export function useSearchOffers() {
	return useMutation<OfferCollection, Error, SearchOfferRequest>({
		mutationFn: (req) =>
			searchOffers({ data: req }) as Promise<OfferCollection>,
	});
}
