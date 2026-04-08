import { useQuery } from "@tanstack/react-query";
import type { GeocoderResponse } from "../types/geocoder";

const GEOCODER_BASE = "https://api.entur.io/geocoder/v1";

async function fetchAutocomplete(
	text: string,
	layers: string,
): Promise<GeocoderResponse> {
	const params = new URLSearchParams({
		text,
		size: "10",
		lang: "no",
		layers,
	});
	const res = await fetch(`${GEOCODER_BASE}/autocomplete?${params}`, {
		headers: { "ET-Client-Name": "wayfare-web" },
	});
	if (!res.ok) throw new Error("Geocoder request failed");
	return res.json() as Promise<GeocoderResponse>;
}

export function useGeocoderAutocomplete(
	query: string,
	layers = "venue",
) {
	return useQuery({
		queryKey: ["geocoder", "autocomplete", layers, query],
		queryFn: () => fetchAutocomplete(query, layers),
		enabled: query.trim().length >= 2,
		staleTime: 1000 * 60 * 5,
		placeholderData: (prev) => prev,
	});
}
