import {
	BusIcon,
	FerryIcon,
	MapPinIcon,
	PlaneIcon,
	TrainIcon,
	TramIcon,
} from "@entur/icons";
import type { PlaceReference } from "../../types/common";
import type { GeocoderFeature, GeocoderResponse } from "../../types/geocoder";
import Combobox, { type ComboboxOption } from "../ui/Combobox";

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
	signal: AbortSignal,
): Promise<ComboboxOption<PlaceReference>[]> {
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
			signal,
		});
		if (!res.ok) return [];
		const data = (await res.json()) as GeocoderResponse;
		return data.features.map((feature) => ({
			value: {
				placeId: feature.properties.id,
				name: feature.properties.label,
			} as PlaceReference,
			label: feature.properties.label,
			icon: getModeIcon(feature),
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
	const selected = value ? { value, label: value.name ?? value.placeId } : null;

	return (
		<Combobox<PlaceReference>
			label={label}
			selected={selected}
			onChange={(opt) => onChange(opt?.value ?? null)}
			getOptions={fetchLocationItems}
			placeholder={placeholder ?? "Search for a stop…"}
			debounceMs={350}
			minQueryLength={2}
			noMatchText="No stops found"
		/>
	);
}
