export type OtpTransportMode =
	| "foot"
	| "bus"
	| "coach"
	| "rail"
	| "tram"
	| "metro"
	| "water"
	| "air"
	| "bicycle"
	| "car"
	| "ferry";

export interface TripPlace {
	name: string;
	quay?: {
		id: string;
		stopPlace?: {
			id: string;
		} | null;
	} | null;
}

export interface TripLeg {
	mode: OtpTransportMode;
	expectedStartTime: string;
	expectedEndTime: string;
	fromPlace: TripPlace;
	toPlace: TripPlace;
	serviceJourney?: { id: string } | null;
	line?: { publicCode?: string | null; name?: string | null } | null;
	authority?: { name: string } | null;
}

export interface TripPattern {
	expectedStartTime: string;
	expectedEndTime: string;
	duration: number; // seconds
	legs: TripLeg[];
}
