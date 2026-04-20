interface DepartureTimePickerProps {
	value: string;
	onChange: (value: string) => void;
}

export default function DepartureTimePicker({
	value,
	onChange,
}: DepartureTimePickerProps) {
	const minDateTime = new Date().toISOString().slice(0, 16);

	return (
		<div className="w-full">
			<label
				htmlFor="departure-datetime"
				className="mb-1.5 block text-sm font-medium"
				style={{ color: "var(--wayfare-text)" }}
			>
				Departure
			</label>
			<input
				id="departure-datetime"
				type="datetime-local"
				value={value}
				min={minDateTime}
				onChange={(e) => onChange(e.target.value)}
				className="w-full rounded-xl border px-3 py-2.5 text-sm outline-none transition-shadow focus:ring-2"
				style={{
					borderColor: "var(--wayfare-line)",
					background: "var(--wayfare-surface-strong)",
					color: "var(--wayfare-text)",
				}}
			/>
		</div>
	);
}
