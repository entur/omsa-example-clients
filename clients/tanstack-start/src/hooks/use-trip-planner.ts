import { useMutation } from "@tanstack/react-query";
import { planTrip } from "../server-functions/trip-planner";
import type { PlaceReference } from "../types/common";
import type { TripPattern } from "../types/trip-planner";

export interface TripSearchInput {
	from: PlaceReference;
	to: PlaceReference;
	dateTime: string;
}

export function useTripPlanner() {
	return useMutation<TripPattern[], Error, TripSearchInput>({
		mutationFn: (input) =>
			planTrip({
				data: {
					from: { place: input.from.placeId },
					to: { place: input.to.placeId },
					dateTime: input.dateTime,
				},
			}) as Promise<TripPattern[]>,
	});
}
