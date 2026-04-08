import { Link } from "@tanstack/react-router";
import { Button } from "@entur/button";

interface PurchaseSuccessProps {
	packageId: string;
}

export default function PurchaseSuccess({ packageId }: PurchaseSuccessProps) {
	return (
		<div className="flex flex-col items-center py-12 text-center">
			<div
				className="mb-4 flex h-16 w-16 items-center justify-center rounded-full"
				style={{ background: "var(--wayfare-accent-soft)" }}
			>
				<svg
					width="32"
					height="32"
					viewBox="0 0 24 24"
					fill="none"
					stroke="var(--wayfare-primary)"
					strokeWidth="2.5"
					aria-hidden="true"
				>
					<path d="M20 6L9 17l-5-5" />
				</svg>
			</div>
			<h2
				className="text-xl font-bold"
				style={{ color: "var(--wayfare-text)" }}
			>
				Purchase confirmed!
			</h2>
			<p
				className="mt-2 text-sm"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				Your ticket is ready. Package ID: <strong>{packageId}</strong>
			</p>
			<div className="mt-6 flex gap-3">
				<Link
					to="/tickets/$packageId"
					params={{ packageId }}
					className="rounded-xl px-5 py-2.5 text-sm font-semibold no-underline"
					style={{ background: "var(--wayfare-primary)", color: "#fff" }}
				>
					View ticket
				</Link>
				<Link
					to="/"
					className="rounded-xl px-5 py-2.5 text-sm font-semibold no-underline"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
						color: "var(--wayfare-text)",
					}}
				>
					Search again
				</Link>
			</div>
		</div>
	);
}
