import { Link } from "@tanstack/react-router";
import { usePackageItem } from "../../hooks/use-documents";
import type { StoredPackage } from "../../types/documents";

interface TicketCardProps {
	pkg: StoredPackage;
}

export default function TicketCard({ pkg }: TicketCardProps) {
	const { data: item } = usePackageItem(pkg.packageId);
	const props = item?.properties;

	const from = props?.from?.name;
	const to = props?.to?.name;
	const purchased = new Date(pkg.savedAt);

	const validFrom = props?.startTime ? new Date(props.startTime) : null;
	const validTo = props?.endTime ? new Date(props.endTime) : null;

	const formatDate = (d: Date) =>
		d.toLocaleDateString("en-GB", {
			day: "numeric",
			month: "short",
			year: "numeric",
		});

	return (
		<Link
			to="/tickets/$packageId"
			params={{ packageId: pkg.packageId }}
			className="block rounded-lg p-4 no-underline transition"
			style={{
				background: "var(--wayfare-surface-strong)",
				border: "1px solid var(--wayfare-line)",
			}}
		>
			<div className="flex items-start justify-between gap-4">
				<div className="min-w-0 flex-1">
					{from && to ? (
						<p
							className="text-sm font-semibold truncate"
							style={{ color: "var(--wayfare-text)", margin: 0 }}
						>
							{from} → {to}
						</p>
					) : (
						<p
							className="text-sm font-semibold font-mono"
							style={{ color: "var(--wayfare-text)", margin: 0 }}
						>
							{pkg.packageId.slice(0, 8)}…
						</p>
					)}
					<p
						className="mt-0.5 text-xs"
						style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
					>
						{validFrom && validTo
							? `Valid ${formatDate(validFrom)} – ${formatDate(validTo)}`
							: `Purchased ${purchased.toLocaleDateString("en-GB", { day: "numeric", month: "short", year: "numeric" })}`}
					</p>
					{validFrom && validTo && (
						<p
							className="mt-0.5 text-xs"
							style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
						>
							Purchased{" "}
							{purchased.toLocaleDateString("en-GB", {
								day: "numeric",
								month: "short",
								year: "numeric",
							})}
						</p>
					)}
				</div>
				<div className="text-right shrink-0">
					<p
						className="text-sm font-bold"
						style={{ color: "var(--wayfare-primary)", margin: 0 }}
					>
						{pkg.price.currencyCode ?? "NOK"} {pkg.price.amount.toFixed(2)}
					</p>
					<span
						className="mt-1 inline-block rounded-full px-2 py-0.5 text-xs font-semibold"
						style={{
							background:
								pkg.status === "CONFIRMED"
									? "rgba(0,160,80,0.1)"
									: "var(--wayfare-accent-soft)",
							color:
								pkg.status === "CONFIRMED"
									? "#006630"
									: "var(--wayfare-primary)",
						}}
					>
						{pkg.status}
					</span>
				</div>
			</div>
		</Link>
	);
}
