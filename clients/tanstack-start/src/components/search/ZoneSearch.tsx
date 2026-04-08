import { useEffect, useRef, useState } from "react";
import { CloseIcon, MapPinIcon } from "@entur/icons";
import { searchFareZones, type FareZone } from "../../lib/fare-zones";
import type { PlaceReference } from "../../types/common";

interface ZoneSearchProps {
	id: string;
	label: string;
	value: PlaceReference | null;
	onChange: (place: PlaceReference | null) => void;
	placeholder?: string;
}

export default function ZoneSearch({
	id,
	label,
	value,
	onChange,
	placeholder = "Search for a zone…",
}: ZoneSearchProps) {
	const [inputText, setInputText] = useState(value?.name ?? "");
	const [open, setOpen] = useState(false);
	const [activeIndex, setActiveIndex] = useState(-1);
	const containerRef = useRef<HTMLDivElement>(null);
	const inputRef = useRef<HTMLInputElement>(null);

	useEffect(() => {
		if (!value) setInputText("");
	}, [value]);

	const results: FareZone[] = searchFareZones(inputText);

	function handleSelect(zone: FareZone) {
		const displayName = `${zone.name} (${zone.operatorName})`;
		onChange({ placeId: zone.id, name: displayName });
		setInputText(displayName);
		setOpen(false);
		setActiveIndex(-1);
	}

	function handleClear() {
		onChange(null);
		setInputText("");
		setOpen(false);
		inputRef.current?.focus();
	}

	function handleKeyDown(e: React.KeyboardEvent) {
		if (e.key === "ArrowDown") {
			e.preventDefault();
			setOpen(true);
			setActiveIndex((i) => Math.min(i + 1, results.length - 1));
		} else if (e.key === "ArrowUp") {
			e.preventDefault();
			setActiveIndex((i) => Math.max(i - 1, 0));
		} else if (e.key === "Enter" && activeIndex >= 0) {
			e.preventDefault();
			handleSelect(results[activeIndex]);
		} else if (e.key === "Escape") {
			setOpen(false);
		}
	}

	useEffect(() => {
		function handleClick(e: MouseEvent) {
			if (!containerRef.current?.contains(e.target as Node)) setOpen(false);
		}
		document.addEventListener("mousedown", handleClick);
		return () => document.removeEventListener("mousedown", handleClick);
	}, []);

	const showDropdown = open && inputText.trim().length > 0;

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
						if (inputText.trim()) setOpen(true);
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
					{inputText ? (
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
					{results.length === 0 ? (
						<div
							className="px-3 py-2.5 text-sm"
							style={{ color: "var(--wayfare-text-secondary)" }}
						>
							No zones found
						</div>
					) : (
						results.map((zone, i) => (
							<div
								key={zone.id}
								id={`${id}-option-${i}`}
								role="option"
								tabIndex={-1}
								aria-selected={i === activeIndex}
								onMouseDown={(e) => {
									e.preventDefault();
									handleSelect(zone);
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
									style={{
										color: "var(--wayfare-text-secondary)",
										flexShrink: 0,
									}}
								>
									<MapPinIcon />
								</span>
								<div className="min-w-0">
									<div className="truncate font-medium">{zone.name}</div>
									<div
										className="truncate text-xs"
										style={{ color: "var(--wayfare-text-secondary)" }}
									>
										{zone.operatorName} · {zone.id}
									</div>
								</div>
							</div>
						))
					)}
				</div>
			)}
		</div>
	);
}
