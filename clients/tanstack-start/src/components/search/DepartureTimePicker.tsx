interface DepartureTimePickerProps {
	value: string;
	onChange: (value: string) => void;
}

export default function DepartureTimePicker({
	value,
	onChange,
}: DepartureTimePickerProps) {
	return (
		<div>
			<label
				htmlFor="depart-time"
				className="mb-1 block text-xs font-semibold uppercase tracking-wide"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				Departure
			</label>
			<input
				id="depart-time"
				type="datetime-local"
				value={value}
				onChange={(e) => onChange(e.target.value)}
				className="w-full rounded-lg border px-3 py-2.5 text-sm outline-none focus:ring-2"
				style={{
					borderColor: "var(--wayfare-line)",
					background: "var(--wayfare-surface-strong)",
					color: "var(--wayfare-text)",
					colorScheme: "light dark",
				}}
			/>
		</div>
	);
}
