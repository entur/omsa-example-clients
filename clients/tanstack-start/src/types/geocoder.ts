export type TransportMode =
	| "bus"
	| "rail"
	| "tram"
	| "metro"
	| "ferry"
	| "air"
	| "coach"
	| "railReplacementBus";

export interface GeocoderGeometry {
	type: "Point";
	coordinates: [number, number]; // [longitude, latitude]
}

export interface GeocoderFeatureProperties {
	id: string;
	gid: string;
	layer: "venue" | "address" | "locality" | "borough" | "county" | "region";
	source: string;
	source_id: string;
	name: string;
	label: string;
	popular_name?: string;
	street?: string;
	accuracy?: string;
	country_a?: string;
	county?: string;
	county_gid?: string;
	locality?: string;
	locality_gid?: string;
	category?: string[];
	mode?: Partial<Record<TransportMode, string | null>>[];
	tariff_zones?: string[];
}

export interface GeocoderFeature {
	type: "Feature";
	geometry: GeocoderGeometry;
	properties: GeocoderFeatureProperties;
}

export interface GeocoderResponse {
	type: "FeatureCollection";
	features: GeocoderFeature[];
	bbox?: [number, number, number, number];
}
