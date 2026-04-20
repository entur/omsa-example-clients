export function formatPrice(amount: number, currency: string): string {
	return new Intl.NumberFormat("no-NO", {
		style: "currency",
		currency,
		minimumFractionDigits: 0,
		maximumFractionDigits: 2,
	}).format(amount);
}
