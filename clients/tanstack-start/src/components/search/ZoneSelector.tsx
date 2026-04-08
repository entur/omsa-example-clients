import ZoneSearch from "./ZoneSearch";
import type { PlaceReference } from "../../types/common";

interface ZoneSelectorProps {
	from: PlaceReference | null;
	to: PlaceReference | null;
	onFromChange: (zone: PlaceReference | null) => void;
	onToChange: (zone: PlaceReference | null) => void;
}

export default function ZoneSelector({
	from,
	to,
	onFromChange,
	onToChange,
}: ZoneSelectorProps) {
	return (
		<div className="grid gap-3 sm:grid-cols-2">
			<ZoneSearch
				id="zone-from"
				label="From"
				value={from}
				placeholder="Search departure zone…"
				onChange={onFromChange}
			/>
			<ZoneSearch
				id="zone-to"
				label="To"
				value={to}
				placeholder="Search destination zone…"
				onChange={onToChange}
			/>
		</div>
	);
}
