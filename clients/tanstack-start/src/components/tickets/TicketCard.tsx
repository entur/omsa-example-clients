import { Link } from "@tanstack/react-router";
import type { StoredPackage } from "../../types/documents";

interface TicketCardProps {
	pkg: StoredPackage;
}

export default function TicketCard({ pkg }: TicketCardProps) {
	const saved = new Date(pkg.savedAt);

	return (
		<Link
			to="/tickets/$packageId"
			params={{ packageId: pkg.packageId }}
			className="block rounded-xl p-4 no-underline transition"
			style={{
				background: "var(--wayfare-surface-strong)",
				border: "1px solid var(--wayfare-line)",
			}}
		>
			<div className="flex items-start justify-between gap-4">
				<div>
					<p
						className="text-sm font-semibold"
						style={{ color: "var(--wayfare-text)", margin: 0 }}
					>
						Package {pkg.packageId.slice(0, 8)}…
					</p>
					<p
						className="mt-0.5 text-xs"
						style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
					>
						Saved {saved.toLocaleDateString()} · {pkg.status}
					</p>
				</div>
				<div className="text-right shrink-0">
					<p
						className="text-sm font-bold"
						style={{ color: "var(--wayfare-primary)", margin: 0 }}
					>
						{pkg.price.currencyCode ?? "NOK"} {pkg.price.amount.toFixed(2)}
					</p>
				</div>
			</div>
		</Link>
	);
}
