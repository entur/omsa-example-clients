import { useEffect, useRef, useState } from "react";
import {
	BusIcon,
	CloseIcon,
	FerryIcon,
	LoadingIcon,
	MapPinIcon,
	PlaneIcon,
	TrainIcon,
	TramIcon,
} from "@entur/icons";
import { useGeocoderAutocomplete } from "../../hooks/use-geocoder";
import type { GeocoderFeature } from "../../types/geocoder";
import type { PlaceReference } from "../../types/common";

function ModeIcon({ feature }: { feature: GeocoderFeature }) {
	const modes = feature.properties.mode ?? [];
	const modeKeys = modes.flatMap((m) => Object.keys(m));
	if (modeKeys.includes("rail")) return <TrainIcon />;
	if (modeKeys.includes("metro") || modeKeys.includes("tram"))
		return <TramIcon />;
	if (modeKeys.includes("ferry")) return <FerryIcon />;
	if (modeKeys.includes("air")) return <PlaneIcon />;
	if (modeKeys.includes("bus")) return <BusIcon />;
	return <MapPinIcon />;
}

interface LocationSearchProps {
	id: string;
	label: string;
	value: PlaceReference | null;
	onChange: (place: PlaceReference | null) => void;
	placeholder?: string;
}

export default function LocationSearch({
	id,
	label,
	value,
	onChange,
	placeholder = "Search for a stop…",
}: LocationSearchProps) {
	const [inputText, setInputText] = useState(value?.name ?? "");
	const [debouncedQuery, setDebouncedQuery] = useState("");
	const [open, setOpen] = useState(false);
	const [activeIndex, setActiveIndex] = useState(-1);
	const containerRef = useRef<HTMLDivElement>(null);
	const inputRef = useRef<HTMLInputElement>(null);

	// Sync display text when value is cleared externally
	useEffect(() => {
		if (!value) setInputText("");
	}, [value]);

	// Debounce query
	useEffect(() => {
		const timer = setTimeout(() => setDebouncedQuery(inputText), 350);
		return () => clearTimeout(timer);
	}, [inputText]);

	const { data, isFetching } = useGeocoderAutocomplete(debouncedQuery);
	const features = data?.features ?? [];

	function handleSelect(feature: GeocoderFeature) {
		onChange({ placeId: feature.properties.id, name: feature.properties.label });
		setInputText(feature.properties.label);
		setOpen(false);
		setActiveIndex(-1);
	}

	function handleClear() {
		onChange(null);
		setInputText("");
		setDebouncedQuery("");
		setOpen(false);
		inputRef.current?.focus();
	}

	function handleKeyDown(e: React.KeyboardEvent) {
		if (e.key === "ArrowDown") {
			e.preventDefault();
			setOpen(true);
			setActiveIndex((i) => Math.min(i + 1, features.length - 1));
		} else if (e.key === "ArrowUp") {
			e.preventDefault();
			setActiveIndex((i) => Math.max(i - 1, 0));
		} else if (e.key === "Enter" && activeIndex >= 0) {
			e.preventDefault();
			handleSelect(features[activeIndex]);
		} else if (e.key === "Escape") {
			setOpen(false);
		}
	}

	// Close on outside click
	useEffect(() => {
		function handleClick(e: MouseEvent) {
			if (!containerRef.current?.contains(e.target as Node)) setOpen(false);
		}
		document.addEventListener("mousedown", handleClick);
		return () => document.removeEventListener("mousedown", handleClick);
	}, []);

	const showDropdown = open && debouncedQuery.length >= 2;

	return (
		<div className="relative" ref={containerRef}>
			<label
				htmlFor={id}
				className="mb-1 block text-xs font-semibold uppercase tracking-wide"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				{label}
			</label>
			<div className="relative flex items-center">
				<input
					ref={inputRef}
					id={id}
					type="text"
					role="combobox"
					value={inputText}
					placeholder={placeholder}
					autoComplete="off"
					aria-autocomplete="list"
					aria-expanded={showDropdown}
					aria-controls={`${id}-listbox`}
					aria-activedescendant={
						activeIndex >= 0 ? `${id}-option-${activeIndex}` : undefined
					}
					onFocus={() => {
						if (debouncedQuery.length >= 2) setOpen(true);
					}}
					onKeyDown={handleKeyDown}
					onChange={(e) => {
						setInputText(e.target.value);
						setOpen(true);
						setActiveIndex(-1);
						if (!e.target.value) onChange(null);
					}}
					className="w-full rounded-lg border px-3 py-2.5 pr-8 text-sm outline-none focus:ring-2"
					style={{
						borderColor: "var(--wayfare-line)",
						background: "var(--wayfare-surface-strong)",
						color: "var(--wayfare-text)",
					}}
				/>
				<span className="pointer-events-none absolute right-2.5 flex items-center">
					{isFetching ? (
						<LoadingIcon className="animate-spin" style={{ color: "var(--wayfare-text-secondary)" }} />
					) : inputText ? (
						<button
							type="button"
							className="pointer-events-auto"
							onClick={handleClear}
							aria-label="Clear selection"
						>
							<CloseIcon style={{ color: "var(--wayfare-text-secondary)" }} />
						</button>
					) : null}
				</span>
			</div>

			{showDropdown && (
				<div
					id={`${id}-listbox`}
					role="listbox"
					className="absolute z-50 mt-1 w-full overflow-hidden rounded-xl shadow-lg"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					{features.length === 0 && !isFetching && (
						<div
							className="px-3 py-2.5 text-sm"
							style={{ color: "var(--wayfare-text-secondary)" }}
						>
							No results found
						</div>
					)}
					{features.map((feature, i) => (
						<div
							key={feature.properties.gid}
							id={`${id}-option-${i}`}
							role="option"
							tabIndex={-1}
							aria-selected={i === activeIndex}
							onMouseDown={(e) => {
								e.preventDefault();
								handleSelect(feature);
							}}
							onMouseEnter={() => setActiveIndex(i)}
							className="flex cursor-pointer items-center gap-2.5 px-3 py-2.5 text-sm transition-colors"
							style={{
								background:
									i === activeIndex
										? "var(--wayfare-accent-soft)"
										: "transparent",
								color: "var(--wayfare-text)",
							}}
						>
							<span
								style={{ color: "var(--wayfare-text-secondary)", flexShrink: 0 }}
							>
								<ModeIcon feature={feature} />
							</span>
							<div className="min-w-0">
								<div className="truncate font-medium">
									{feature.properties.name}
								</div>
								{feature.properties.locality &&
									feature.properties.locality !== feature.properties.name && (
										<div
											className="truncate text-xs"
											style={{ color: "var(--wayfare-text-secondary)" }}
										>
											{feature.properties.locality}
										</div>
									)}
							</div>
						</div>
					))}
				</div>
			)}
		</div>
	);
}
