import { useState } from "react";
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

	const total = travelers.reduce((sum, t) => sum + t.count, 0);

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

	const btnStyle: React.CSSProperties = {
		border: `1px solid var(--wayfare-line)`,
		background: "var(--wayfare-surface-strong)",
		color: "var(--wayfare-text)",
		borderRadius: 8,
		padding: "10px 14px",
		fontSize: 14,
		cursor: "pointer",
		width: "100%",
		textAlign: "left",
	};

	return (
		<div className="relative">
			<p
				className="mb-1 block text-xs font-semibold uppercase tracking-wide"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				Travelers
			</p>
			<button type="button" style={btnStyle} onClick={() => setOpen((o) => !o)}>
				{total === 0
					? "Add travelers"
					: `${total} traveler${total !== 1 ? "s" : ""}`}
			</button>

			{open && (
				<div
					className="absolute left-0 right-0 top-full z-10 mt-1 rounded-xl p-4 shadow-lg"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: `1px solid var(--wayfare-line)`,
					}}
				>
					{GROUPS.map((group) => (
						<div
							key={group.id}
							className="flex items-center justify-between py-2"
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
									className="flex h-7 w-7 items-center justify-center rounded-full text-lg font-bold"
									style={{
										background: "var(--wayfare-accent-soft)",
										color: "var(--wayfare-primary)",
										border: "none",
										cursor: "pointer",
									}}
								>
									−
								</button>
								<span
									className="w-4 text-center text-sm font-semibold"
									style={{ color: "var(--wayfare-text)" }}
								>
									{getCount(group.id)}
								</span>
								<button
									type="button"
									onClick={() => setCount(group.id, getCount(group.id) + 1)}
									className="flex h-7 w-7 items-center justify-center rounded-full text-lg font-bold"
									style={{
										background: "var(--wayfare-accent-soft)",
										color: "var(--wayfare-primary)",
										border: "none",
										cursor: "pointer",
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
						className="mt-3 w-full rounded-lg py-2 text-sm font-semibold"
						style={{
							background: "var(--wayfare-primary)",
							color: "#fff",
							border: "none",
							cursor: "pointer",
						}}
					>
						Done
					</button>
				</div>
			)}
		</div>
	);
}
