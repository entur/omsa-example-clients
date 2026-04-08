import ReactMarkdown from "react-markdown";
import type { Offer } from "../../types/search";

interface OfferCardProps {
	offer: Offer;
	selected?: boolean;
	onSelect?: () => void;
}

function formatPrice(amount: number, currency: string): string {
	return new Intl.NumberFormat("no-NO", {
		style: "currency",
		currency,
		minimumFractionDigits: 0,
		maximumFractionDigits: 2,
	}).format(amount);
}

function Badge({ label, positive }: { label: string; positive: boolean }) {
	return (
		<span
			className="inline-flex items-center rounded-full px-2 py-0.5 text-xs font-medium"
			style={{
				background: positive ? "rgba(22,163,74,0.10)" : "var(--wayfare-bg)",
				color: positive ? "rgb(22,163,74)" : "var(--wayfare-text-secondary)",
			}}
		>
			{label}
		</span>
	);
}

export default function OfferCard({
	offer,
	selected = false,
	onSelect,
}: OfferCardProps) {
	const summary = offer.properties?.summary;
	const price = offer.properties?.price;
	const zones = summary?.geographicalValidity?.zonalValidity?.fareZones ?? [];
	const zoneCount = zones.length;

	const name =
		summary?.name ??
		offer.properties?.products?.[0]?.productName ??
		"Travel Offer";
	const description =
		summary?.description && summary.description !== name
			? summary.description.replace(/\\n/g, "\n")
			: null;

	return (
		<label
			className="block cursor-pointer rounded-xl border p-4 transition-all"
			style={{
				borderColor: selected
					? "var(--wayfare-primary)"
					: "var(--wayfare-line)",
				background: selected
					? "var(--wayfare-accent-soft)"
					: "var(--wayfare-surface-strong)",
			}}
		>
			<input
				type="radio"
				name="offer-selection"
				value={offer.id ?? ""}
				checked={selected}
				onChange={() => onSelect?.()}
				className="sr-only"
			/>
			<div className="flex items-start justify-between gap-3">
				<span
					className="text-sm font-semibold"
					style={{ color: "var(--wayfare-text)" }}
				>
					{name}
				</span>
				{price && (
					<span
						className="shrink-0 text-sm font-bold"
						style={{ color: "var(--wayfare-primary)" }}
					>
						{formatPrice(price.amount, price.currencyCode ?? "NOK")}
					</span>
				)}
			</div>
			{description && (
				<div
					className="prose prose-xs max-w-none text-xs"
					style={
						{
							"--tw-prose-body": "var(--wayfare-text-secondary)",
							"--tw-prose-bullets": "var(--wayfare-text-secondary)",
							"--tw-prose-links": "var(--wayfare-primary)",
						} as React.CSSProperties
					}
				>
					<ReactMarkdown
						components={{
							a: ({ href, children }) => (
								<a
									href={href}
									target="_blank"
									rel="noreferrer noopener"
									style={{ color: "var(--wayfare-primary)" }}
								>
									{children}
								</a>
							),
							p: ({ children }) => <p style={{ margin: 0 }}>{children}</p>,
							ul: ({ children }) => <ul className="pl-4">{children}</ul>,
							li: ({ children }) => <li className="my-0">{children}</li>,
						}}
					>
						{description}
					</ReactMarkdown>
				</div>
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
					<Badge
						label={`${zoneCount} zone${zoneCount !== 1 ? "s" : ""}`}
						positive={false}
					/>
				)}
			</div>
		</label>
	);
}
