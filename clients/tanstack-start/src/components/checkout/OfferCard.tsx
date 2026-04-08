import type { Offer } from "../../types/search";

interface OfferCardProps {
	offer: Offer;
	selected: boolean;
	onSelect: () => void;
}

function formatPrice(amount: number, currency: string): string {
	return new Intl.NumberFormat("no-NO", {
		style: "currency",
		currency,
		minimumFractionDigits: 0,
		maximumFractionDigits: 2,
	}).format(amount);
}

function Badge({
	label,
	positive,
}: {
	label: string;
	positive: boolean;
}) {
	return (
		<span
			className="inline-block rounded-full px-2 py-0.5 text-xs font-medium"
			style={{
				background: positive
					? "rgba(22,163,74,0.10)"
					: "rgba(156,163,175,0.15)",
				color: positive ? "rgb(22,163,74)" : "var(--wayfare-text-secondary)",
			}}
		>
			{label}
		</span>
	);
}

export default function OfferCard({ offer, selected, onSelect }: OfferCardProps) {
	const summary = offer.properties?.summary;
	const price = offer.properties?.price;
	const zones = summary?.geographicalValidity?.zonalValidity?.fareZones ?? [];
	const zoneCount = zones.length;

	const name = summary?.name ?? offer.properties?.products?.[0]?.productName ?? "Travel Offer";
	const description = summary?.description && summary.description !== name
		? summary.description
		: null;

	return (
		<button
			type="button"
			onClick={onSelect}
			className="w-full rounded-xl p-4 text-left transition"
			style={{
				background: selected
					? "var(--wayfare-accent-soft)"
					: "var(--wayfare-surface-strong)",
				border: `2px solid ${selected ? "var(--wayfare-primary)" : "var(--wayfare-line)"}`,
				cursor: "pointer",
			}}
		>
			<div className="flex items-start justify-between gap-4">
				{/* Radio indicator */}
				<span
					className="mt-1 flex h-4 w-4 shrink-0 items-center justify-center rounded-full border-2"
					style={{
						borderColor: selected ? "var(--wayfare-primary)" : "var(--wayfare-line)",
						background: selected ? "var(--wayfare-primary)" : "transparent",
					}}
				>
					{selected && (
						<span className="h-1.5 w-1.5 rounded-full" style={{ background: "#fff" }} />
					)}
				</span>

				{/* Main content */}
				<div className="min-w-0 flex-1">
					<p
						className="text-sm font-semibold leading-tight"
						style={{ color: "var(--wayfare-text)", margin: 0 }}
					>
						{name}
					</p>
					{description && (
						<p
							className="mt-0.5 text-xs"
							style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
						>
							{description}
						</p>
					)}
					<div className="mt-2 flex flex-wrap gap-1.5">
						{summary?.isRefundable != null && (
							<Badge
								label={summary.isRefundable ? "Refundable" : "Non-refundable"}
								positive={summary.isRefundable}
							/>
						)}
						{summary?.isExchangeable != null && (
							<Badge
								label={summary.isExchangeable ? "Exchangeable" : "Non-exchangeable"}
								positive={summary.isExchangeable}
							/>
						)}
						{zoneCount > 0 && (
							<Badge label={`${zoneCount} zone${zoneCount !== 1 ? "s" : ""}`} positive={false} />
						)}
					</div>
				</div>

				{/* Price */}
				{price && (
					<div className="shrink-0 text-right">
						<p
							className="text-base font-bold"
							style={{ color: "var(--wayfare-primary)", margin: 0 }}
						>
							{formatPrice(price.amount, price.currencyCode ?? "NOK")}
						</p>
					</div>
				)}
			</div>
		</button>
	);
}
