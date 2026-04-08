import { SearchableDropdown } from "@entur/dropdown";
import type { NormalizedDropdownItemType } from "@entur/dropdown";
import { searchFareZones } from "../../lib/fare-zones";
import type { PlaceReference } from "../../types/common";

function fetchZoneItems(input: string) {
	if (!input.trim()) return [];
	return searchFareZones(input).map((zone) => ({
		value: {
			placeId: zone.id,
			name: `${zone.name} (${zone.operatorName})`,
		} as PlaceReference,
		label: `${zone.name} (${zone.operatorName})`,
	}));
}

interface ZoneSearchProps {
	label: string;
	value: PlaceReference | null;
	onChange: (place: PlaceReference | null) => void;
	placeholder?: string;
}

export default function ZoneSearch({
	label,
	value,
	onChange,
	placeholder,
}: ZoneSearchProps) {
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
			items={fetchZoneItems}
			selectedItem={selectedItem}
			onChange={handleChange}
			placeholder={placeholder ?? "Search for a zone…"}
			clearable
			noMatchesText="No zones found"
		/>
	);
}
