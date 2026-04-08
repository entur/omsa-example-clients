import { RadioPanel } from "@entur/form";
import { Tag } from "@entur/layout";
import ReactMarkdown from "react-markdown";
import type { Offer } from "../../types/search";

interface OfferCardProps {
	offer: Offer;
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
		<Tag
			compact
			style={{
				background: positive ? "rgba(22,163,74,0.10)" : undefined,
				color: positive ? "rgb(22,163,74)" : undefined,
			}}
		>
			{label}
		</Tag>
	);
}

export default function OfferCard({ offer }: OfferCardProps) {
	const summary = offer.properties?.summary;
	const price = offer.properties?.price;
	const zones = summary?.geographicalValidity?.zonalValidity?.fareZones ?? [];
	const zoneCount = zones.length;

	const name = summary?.name ?? offer.properties?.products?.[0]?.productName ?? "Travel Offer";
	const description = summary?.description && summary.description !== name
		? summary.description.replace(/\\n/g, "\n")
		: null;

	return (
		<RadioPanel
			value={offer.id ?? ""}
			title={name}
			secondaryLabel={price ? formatPrice(price.amount, price.currencyCode ?? "NOK") : undefined}
			className="!w-full"
		>
			{description && (
				<div
					className="prose prose-xs max-w-none text-xs"
					style={{
						"--tw-prose-body": "var(--wayfare-text-secondary)",
						"--tw-prose-bullets": "var(--wayfare-text-secondary)",
						"--tw-prose-links": "var(--wayfare-primary)",
					} as React.CSSProperties}
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
							p: ({ children }) => (
								<p style={{ margin: 0 }}>{children}</p>
							),
							ul: ({ children }) => (
								<ul className="pl-4">{children}</ul>
							),
							li: ({ children }) => (
								<li className="my-0">{children}</li>
							),
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
					<Badge label={`${zoneCount} zone${zoneCount !== 1 ? "s" : ""}`} positive={false} />
				)}
			</div>
		</RadioPanel>
	);
}
