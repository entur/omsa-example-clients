import { SearchableDropdown } from "@entur/dropdown";
import type { NormalizedDropdownItemType } from "@entur/dropdown";
import {
	BusIcon,
	FerryIcon,
	MapPinIcon,
	PlaneIcon,
	TrainIcon,
	TramIcon,
} from "@entur/icons";
import type { GeocoderFeature, GeocoderResponse } from "../../types/geocoder";
import type { PlaceReference } from "../../types/common";

const GEOCODER_BASE = "https://api.entur.io/geocoder/v1";

function getModeIcon(feature: GeocoderFeature): React.ComponentType {
	const modeKeys = (feature.properties.mode ?? []).flatMap((m) =>
		Object.keys(m),
	);
	if (modeKeys.includes("rail")) return TrainIcon;
	if (modeKeys.includes("metro") || modeKeys.includes("tram")) return TramIcon;
	if (modeKeys.includes("ferry")) return FerryIcon;
	if (modeKeys.includes("air")) return PlaneIcon;
	if (modeKeys.includes("bus")) return BusIcon;
	return MapPinIcon;
}

async function fetchLocationItems(
	input: string,
	abortControllerRef: React.MutableRefObject<AbortController>,
) {
	if (input.trim().length < 2) return [];
	const params = new URLSearchParams({
		text: input,
		size: "10",
		lang: "no",
		layers: "venue",
	});
	try {
		const res = await fetch(`${GEOCODER_BASE}/autocomplete?${params}`, {
			headers: { "ET-Client-Name": "wayfare-web" },
			signal: abortControllerRef.current.signal,
		});
		if (!res.ok) return [];
		const data = (await res.json()) as GeocoderResponse;
		return data.features.map((feature) => ({
			value: {
				placeId: feature.properties.id,
				name: feature.properties.label,
			} as PlaceReference,
			label: feature.properties.label,
			icons: [getModeIcon(feature)],
		}));
	} catch {
		return [];
	}
}

interface LocationSearchProps {
	label: string;
	value: PlaceReference | null;
	onChange: (place: PlaceReference | null) => void;
	placeholder?: string;
}

export default function LocationSearch({
	label,
	value,
	onChange,
	placeholder,
}: LocationSearchProps) {
	const selectedItem = value
		? { value, label: value.name ?? value.placeId }
		: null;

	function handleChange(
		item: NormalizedDropdownItemType<PlaceReference> | null,
	) {
		onChange(item?.value ?? null);
	}

	return (
		<SearchableDropdown<PlaceReference>
			label={label}
			items={fetchLocationItems}
			selectedItem={selectedItem}
			onChange={handleChange}
			placeholder={placeholder ?? "Search for a stop…"}
			clearable
			debounceTimeout={350}
			noMatchesText="No stops found"
		/>
	);
}
