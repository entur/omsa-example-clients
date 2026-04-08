interface PaymentMethodPickerProps {
	selected: string | null;
	onSelect: (method: string) => void;
}

const PAYMENT_METHODS = [
	{
		id: "NETS_EASY",
		label: "Card (Nets Easy)",
		description: "Pay with debit or credit card",
	},
	{ id: "VIPPS", label: "Vipps", description: "Pay with Vipps mobile payment" },
];

export default function PaymentMethodPicker({
	selected,
	onSelect,
}: PaymentMethodPickerProps) {
	return (
		<div className="flex flex-col gap-2">
			<p
				className="text-xs font-semibold uppercase tracking-wide"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				Payment method
			</p>
			{PAYMENT_METHODS.map((method) => {
				const isSelected = selected === method.id;
				return (
					<button
						key={method.id}
						type="button"
						onClick={() => onSelect(method.id)}
						className="w-full rounded-xl p-4 text-left transition"
						style={{
							background: isSelected
								? "var(--wayfare-accent-soft)"
								: "var(--wayfare-surface-strong)",
							border: `2px solid ${isSelected ? "var(--wayfare-primary)" : "var(--wayfare-line)"}`,
							cursor: "pointer",
						}}
					>
						<div className="flex items-center gap-3">
							<span
								className="flex h-4 w-4 shrink-0 items-center justify-center rounded-full border-2"
								style={{
									borderColor: isSelected
										? "var(--wayfare-primary)"
										: "var(--wayfare-line)",
									background: isSelected
										? "var(--wayfare-primary)"
										: "transparent",
								}}
							>
								{isSelected && (
									<span
										className="h-1.5 w-1.5 rounded-full"
										style={{ background: "#fff" }}
									/>
								)}
							</span>
							<div>
								<p
									className="text-sm font-semibold"
									style={{ color: "var(--wayfare-text)", margin: 0 }}
								>
									{method.label}
								</p>
								<p
									className="text-xs"
									style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
								>
									{method.description}
								</p>
							</div>
						</div>
					</button>
				);
			})}
		</div>
	);
}
