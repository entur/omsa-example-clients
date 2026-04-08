import { useState } from "react";
import { Button, SecondarySquareButton } from "@entur/button";
import {
	Popover,
	PopoverCloseButton,
	PopoverContent,
	PopoverTrigger,
} from "@entur/tooltip";
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
	const summary =
		total === 0 ? "Add travelers" : `${total} traveler${total !== 1 ? "s" : ""}`;

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
		<Popover showPopover={open} setShowPopover={setOpen}>
			<PopoverTrigger>
				<Button type="button" variant="secondary" width="fluid">
					{summary}
				</Button>
			</PopoverTrigger>
			<PopoverContent className="p-4" style={{ minWidth: "260px" }}>
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
							<SecondarySquareButton
								size="small"
								type="button"
								onClick={() => setCount(group.id, getCount(group.id) - 1)}
								aria-label={`Remove ${group.label}`}
							>
								−
							</SecondarySquareButton>
							<span
								className="w-4 text-center text-sm font-semibold"
								style={{ color: "var(--wayfare-text)" }}
							>
								{getCount(group.id)}
							</span>
							<SecondarySquareButton
								size="small"
								type="button"
								onClick={() => setCount(group.id, getCount(group.id) + 1)}
								aria-label={`Add ${group.label}`}
							>
								+
							</SecondarySquareButton>
						</div>
					</div>
				))}
				<PopoverCloseButton>
					<Button
						type="button"
						variant="secondary"
						width="fluid"
						className="mt-3"
					>
						Done
					</Button>
				</PopoverCloseButton>
			</PopoverContent>
		</Popover>
	);
}
