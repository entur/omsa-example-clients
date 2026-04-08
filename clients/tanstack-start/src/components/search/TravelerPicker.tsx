import { DownArrowIcon, UsersIcon } from "@entur/icons";
import { useEffect, useRef, useState } from "react";
import type { TravelerGroup } from "../../context/search-form";

const GROUPS: {
	id: TravelerGroup["ageGroup"];
	label: string;
	minAge?: number;
	maxAge?: number;
}[] = [
	{ id: "ADULT", label: "Adult", minAge: 18 },
	{ id: "YOUTH", label: "Youth", minAge: 16, maxAge: 17 },
	{ id: "CHILD", label: "Child", minAge: 6, maxAge: 15 },
	{ id: "SENIOR", label: "Senior", minAge: 67 },
];

interface TravelerPickerProps {
	travelers: TravelerGroup[];
	onChange: (travelers: TravelerGroup[]) => void;
}

export default function TravelerPicker({
	travelers,
	onChange,
}: TravelerPickerProps) {
	const [open, setOpen] = useState(false);
	const containerRef = useRef<HTMLDivElement>(null);

	const total = travelers.reduce((sum, t) => sum + t.count, 0);
	const summary =
		total === 0
			? "Add travelers"
			: `${total} traveler${total !== 1 ? "s" : ""}`;

	// Close on outside click
	useEffect(() => {
		function handlePointerDown(e: PointerEvent) {
			if (
				containerRef.current &&
				!containerRef.current.contains(e.target as Node)
			) {
				setOpen(false);
			}
		}
		document.addEventListener("pointerdown", handlePointerDown);
		return () => document.removeEventListener("pointerdown", handlePointerDown);
	}, []);

	function getCount(ageGroup: TravelerGroup["ageGroup"]) {
		return travelers.find((t) => t.ageGroup === ageGroup)?.count ?? 0;
	}

	function setCount(ageGroup: TravelerGroup["ageGroup"], count: number) {
		if (count < 0) return;
		const existing = travelers.filter((t) => t.ageGroup !== ageGroup);
		const group = GROUPS.find((g) => g.id === ageGroup) ?? GROUPS[0];
		if (count === 0) {
			onChange(existing);
		} else {
			onChange([
				...existing,
				{
					id: ageGroup.toLowerCase(),
					ageGroup,
					count,
					minAge: group.minAge,
					maxAge: group.maxAge,
				},
			]);
		}
	}

	return (
		<div ref={containerRef} className="relative w-full">
			<button
				type="button"
				onClick={() => setOpen((v) => !v)}
				className="flex w-full items-center justify-between rounded-xl border px-3 py-2.5 text-sm font-medium transition-shadow focus:outline-none focus:ring-2"
				style={{
					borderColor: "var(--wayfare-line)",
					background: "var(--wayfare-surface-strong)",
					color:
						total === 0
							? "var(--wayfare-text-secondary)"
							: "var(--wayfare-text)",
					// @ts-expect-error - css custom prop
					"--tw-ring-color":
						"color-mix(in srgb, var(--wayfare-primary) 30%, transparent)",
				}}
				aria-haspopup="dialog"
				aria-expanded={open}
			>
				<span className="flex items-center gap-2">
					<UsersIcon
						aria-hidden="true"
						style={{ color: "var(--wayfare-text-secondary)" }}
					/>
					{summary}
				</span>
				<DownArrowIcon
					aria-hidden="true"
					className={`transition-transform ${open ? "rotate-180" : ""}`}
					style={{ color: "var(--wayfare-text-secondary)" }}
				/>
			</button>

			{open && (
				<div
					className="absolute z-50 mt-1 w-full min-w-[260px] rounded-xl border p-4 shadow-lg"
					style={{
						borderColor: "var(--wayfare-line)",
						background: "var(--wayfare-surface-strong)",
					}}
					role="dialog"
					aria-label="Select travelers"
				>
					{GROUPS.map((group) => (
						<div
							key={group.id}
							className="flex items-center justify-between py-2.5"
							style={{
								borderBottom: "1px solid var(--wayfare-line)",
							}}
						>
							<div>
								<span
									className="text-sm font-medium"
									style={{ color: "var(--wayfare-text)" }}
								>
									{group.label}
								</span>
								{(group.minAge !== undefined || group.maxAge !== undefined) && (
									<span
										className="ml-2 text-xs"
										style={{ color: "var(--wayfare-text-secondary)" }}
									>
										{group.minAge && group.maxAge
											? `${group.minAge}–${group.maxAge} yrs`
											: group.minAge
												? `${group.minAge}+ yrs`
												: ""}
									</span>
								)}
							</div>
							<div className="flex items-center gap-3">
								<button
									type="button"
									onClick={() => setCount(group.id, getCount(group.id) - 1)}
									disabled={getCount(group.id) === 0}
									aria-label={`Remove ${group.label}`}
									className="flex h-7 w-7 items-center justify-center rounded-lg border text-sm font-semibold transition-colors disabled:cursor-not-allowed disabled:opacity-40"
									style={{
										borderColor: "var(--wayfare-line)",
										color: "var(--wayfare-text)",
										background: "transparent",
									}}
								>
									−
								</button>
								<span
									className="w-4 text-center text-sm font-semibold tabular-nums"
									style={{ color: "var(--wayfare-text)" }}
								>
									{getCount(group.id)}
								</span>
								<button
									type="button"
									onClick={() => setCount(group.id, getCount(group.id) + 1)}
									aria-label={`Add ${group.label}`}
									className="flex h-7 w-7 items-center justify-center rounded-lg border text-sm font-semibold transition-colors"
									style={{
										borderColor: "var(--wayfare-line)",
										color: "var(--wayfare-text)",
										background: "transparent",
									}}
								>
									+
								</button>
							</div>
						</div>
					))}
					<button
						type="button"
						onClick={() => setOpen(false)}
						className="mt-3 w-full rounded-xl border py-2 text-sm font-medium transition-colors"
						style={{
							borderColor: "var(--wayfare-line)",
							color: "var(--wayfare-text)",
							background: "transparent",
						}}
					>
						Done
					</button>
				</div>
			)}
		</div>
	);
}
