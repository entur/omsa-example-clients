import { CloseSmallIcon, SearchIcon } from "@entur/icons";
import { useEffect, useId, useRef, useState } from "react";

export interface ComboboxOption<T = string> {
	value: T;
	label: string;
	icon?: React.ComponentType;
}

interface ComboboxProps<T> {
	label: string;
	selected: ComboboxOption<T> | null;
	onChange: (option: ComboboxOption<T> | null) => void;
	getOptions: (
		query: string,
		signal: AbortSignal,
	) => ComboboxOption<T>[] | Promise<ComboboxOption<T>[]>;
	placeholder?: string;
	debounceMs?: number;
	noMatchText?: string;
	minQueryLength?: number;
}

export default function Combobox<T>({
	label,
	selected,
	onChange,
	getOptions,
	placeholder = "Search…",
	debounceMs = 300,
	noMatchText = "No results found",
	minQueryLength = 1,
}: ComboboxProps<T>) {
	const id = useId();
	const listboxId = `${id}-listbox`;
	const inputId = `${id}-input`;

	const [inputValue, setInputValue] = useState(selected?.label ?? "");
	const [options, setOptions] = useState<ComboboxOption<T>[]>([]);
	const [isOpen, setIsOpen] = useState(false);
	const [loading, setLoading] = useState(false);
	const [activeIndex, setActiveIndex] = useState(-1);

	const abortRef = useRef<AbortController | null>(null);
	const debounceRef = useRef<ReturnType<typeof setTimeout> | null>(null);
	const containerRef = useRef<HTMLDivElement>(null);
	const inputRef = useRef<HTMLInputElement>(null);

	// Sync input display when selection is changed externally
	useEffect(() => {
		setInputValue(selected?.label ?? "");
	}, [selected?.label]);

	// Close dropdown on outside click
	useEffect(() => {
		function handlePointerDown(e: PointerEvent) {
			if (
				containerRef.current &&
				!containerRef.current.contains(e.target as Node)
			) {
				setIsOpen(false);
				setInputValue(selected?.label ?? "");
			}
		}
		document.addEventListener("pointerdown", handlePointerDown);
		return () => document.removeEventListener("pointerdown", handlePointerDown);
	}, [selected?.label]);

	function triggerSearch(query: string) {
		abortRef.current?.abort();
		abortRef.current = new AbortController();
		const signal = abortRef.current.signal;

		if (debounceRef.current) clearTimeout(debounceRef.current);

		debounceRef.current = setTimeout(async () => {
			setLoading(true);
			try {
				const results = await getOptions(query, signal);
				if (!signal.aborted) {
					setOptions(results);
					setIsOpen(true);
				}
			} catch (err: unknown) {
				if ((err as Error)?.name !== "AbortError") {
					setOptions([]);
				}
			} finally {
				if (!signal.aborted) setLoading(false);
			}
		}, debounceMs);
	}

	function handleInputChange(e: React.ChangeEvent<HTMLInputElement>) {
		const val = e.target.value;
		setInputValue(val);
		setActiveIndex(-1);
		if (selected) onChange(null);

		if (val.length >= minQueryLength) {
			triggerSearch(val);
		} else {
			abortRef.current?.abort();
			if (debounceRef.current) clearTimeout(debounceRef.current);
			setOptions([]);
			setIsOpen(false);
			setLoading(false);
		}
	}

	function handleSelect(option: ComboboxOption<T>) {
		onChange(option);
		setInputValue(option.label);
		setIsOpen(false);
		setOptions([]);
		setActiveIndex(-1);
	}

	function handleClear(e: React.MouseEvent) {
		e.preventDefault();
		e.stopPropagation();
		onChange(null);
		setInputValue("");
		setOptions([]);
		setIsOpen(false);
		inputRef.current?.focus();
	}

	function handleKeyDown(e: React.KeyboardEvent<HTMLInputElement>) {
		if (!isOpen) {
			if (e.key === "ArrowDown" && inputValue.length >= minQueryLength) {
				triggerSearch(inputValue);
			}
			return;
		}
		if (e.key === "ArrowDown") {
			e.preventDefault();
			setActiveIndex((i) => Math.min(i + 1, options.length - 1));
		} else if (e.key === "ArrowUp") {
			e.preventDefault();
			setActiveIndex((i) => Math.max(i - 1, 0));
		} else if (e.key === "Enter" && activeIndex >= 0) {
			e.preventDefault();
			handleSelect(options[activeIndex]);
		} else if (e.key === "Escape") {
			setIsOpen(false);
			setInputValue(selected?.label ?? "");
		}
	}

	const showNoMatch =
		isOpen &&
		!loading &&
		options.length === 0 &&
		inputValue.length >= minQueryLength;

	function serializeOptionValue(value: T): string {
		if (
			typeof value === "string" ||
			typeof value === "number" ||
			typeof value === "boolean"
		) {
			return String(value);
		}
		try {
			return JSON.stringify(value);
		} catch {
			return "value";
		}
	}

	const optionOccurrenceCount = new Map<string, number>();
	const keyedOptions = options.map((option) => {
		const baseKey = `${option.label}-${serializeOptionValue(option.value)}`;
		const count = optionOccurrenceCount.get(baseKey) ?? 0;
		optionOccurrenceCount.set(baseKey, count + 1);
		const key = count === 0 ? baseKey : `${baseKey}-${count}`;
		return { option, key };
	});

	const activeOptionId =
		activeIndex >= 0 && keyedOptions[activeIndex]
			? `${listboxId}-opt-${keyedOptions[activeIndex].key}`
			: undefined;

	return (
		<div ref={containerRef} className="relative w-full">
			<label
				htmlFor={inputId}
				className="mb-1.5 block text-sm font-medium"
				style={{ color: "var(--wayfare-text)" }}
			>
				{label}
			</label>
			<div className="relative flex items-center">
				<input
					ref={inputRef}
					id={inputId}
					type="text"
					role="combobox"
					aria-expanded={isOpen}
					aria-autocomplete="list"
					aria-controls={listboxId}
					aria-activedescendant={activeOptionId}
					value={inputValue}
					onChange={handleInputChange}
					onKeyDown={handleKeyDown}
					placeholder={placeholder}
					autoComplete="off"
					className="w-full rounded-xl border py-2.5 pl-3 pr-10 text-sm outline-none transition-shadow focus:ring-2"
					style={{
						borderColor: "var(--wayfare-line)",
						background: "var(--wayfare-surface-strong)",
						color: "var(--wayfare-text)",
						// @ts-expect-error - css custom prop
						"--tw-ring-color":
							"color-mix(in srgb, var(--wayfare-primary) 30%, transparent)",
					}}
				/>
				<div className="pointer-events-none absolute right-3 flex items-center gap-1">
					{loading && (
						<svg
							className="h-4 w-4 animate-spin"
							fill="none"
							viewBox="0 0 24 24"
							aria-hidden="true"
							style={{ color: "var(--wayfare-text-secondary)" }}
						>
							<circle
								className="opacity-25"
								cx="12"
								cy="12"
								r="10"
								stroke="currentColor"
								strokeWidth="4"
							/>
							<path
								className="opacity-75"
								fill="currentColor"
								d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4z"
							/>
						</svg>
					)}
					{!loading && !selected && (
						<SearchIcon
							aria-hidden="true"
							style={{ color: "var(--wayfare-text-secondary)" }}
						/>
					)}
				</div>
				{selected && !loading && (
					<button
						type="button"
						onPointerDown={handleClear}
						className="absolute right-2.5 flex h-5 w-5 items-center justify-center rounded-full transition-colors hover:bg-[var(--wayfare-bg)]"
						style={{ color: "var(--wayfare-text-secondary)" }}
						aria-label="Clear selection"
					>
						<CloseSmallIcon aria-hidden="true" />
					</button>
				)}
			</div>

			{isOpen && options.length > 0 && (
				<div
					id={listboxId}
					role="listbox"
					className="absolute z-50 mt-1 w-full overflow-auto rounded-xl border shadow-lg"
					style={{
						maxHeight: "260px",
						borderColor: "var(--wayfare-line)",
						background: "var(--wayfare-surface-strong)",
					}}
				>
					{keyedOptions.map(({ option, key }, i) => {
						const Icon = option.icon;
						return (
							<button
								key={key}
								id={`${listboxId}-opt-${key}`}
								type="button"
								role="option"
								aria-selected={i === activeIndex}
								onPointerDown={(e) => {
									e.preventDefault();
									handleSelect(option);
								}}
								onPointerEnter={() => setActiveIndex(i)}
								className="flex w-full cursor-pointer items-center gap-2.5 px-3 py-2.5 text-left text-sm transition-colors"
								style={{
									background:
										i === activeIndex
											? "var(--wayfare-accent-soft)"
											: undefined,
									color: "var(--wayfare-text)",
								}}
							>
								{Icon && (
									<span
										className="flex h-4 w-4 shrink-0 items-center justify-center"
										style={{ color: "var(--wayfare-text-secondary)" }}
									>
										<Icon />
									</span>
								)}
								{option.label}
							</button>
						);
					})}
				</div>
			)}

			{showNoMatch && (
				<div
					className="absolute z-50 mt-1 w-full rounded-xl border px-3 py-3 text-sm shadow-lg"
					style={{
						borderColor: "var(--wayfare-line)",
						background: "var(--wayfare-surface-strong)",
						color: "var(--wayfare-text-secondary)",
					}}
				>
					{noMatchText}
				</div>
			)}
		</div>
	);
}
