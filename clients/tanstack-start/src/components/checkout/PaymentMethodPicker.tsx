import { RadioGroup, RadioPanel } from "@entur/form";

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
			<RadioGroup
				name="payment-method"
				value={selected}
				onChange={(e) => onSelect(e.target.value)}
			>
				<div className="flex flex-col gap-2">
					{PAYMENT_METHODS.map((method) => (
						<RadioPanel
							key={method.id}
							value={method.id}
							title={method.label}
							className="!w-full"
						>
							<p
								className="text-xs"
								style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
							>
								{method.description}
							</p>
						</RadioPanel>
					))}
				</div>
			</RadioGroup>
		</div>
	);
}
