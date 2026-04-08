import { createFileRoute, Link } from "@tanstack/react-router";
import { Button } from "@entur/button";
import PageShell from "../../components/layout/PageShell";
import TicketCard from "../../components/tickets/TicketCard";
import { getPackages } from "../../lib/ticket-storage";

export const Route = createFileRoute("/tickets/")({ component: TicketsPage });

function TicketsPage() {
	const packages = getPackages();

	if (packages.length === 0) {
		return (
			<PageShell title="My tickets" subtitle="Your purchased travel tickets">
				<div className="mt-12 flex flex-col items-center text-center">
					<div
						className="mb-4 flex h-16 w-16 items-center justify-center rounded-full"
						style={{ background: "var(--wayfare-accent-soft)" }}
					>
						<svg
							width="28"
							height="28"
							viewBox="0 0 24 24"
							fill="none"
							stroke="var(--wayfare-primary)"
							strokeWidth="2"
							aria-hidden="true"
						>
							<rect x="1" y="4" width="22" height="16" rx="2" ry="2" />
							<line x1="1" y1="10" x2="23" y2="10" />
						</svg>
					</div>
					<p
						className="text-sm font-medium"
						style={{ color: "var(--wayfare-text)" }}
					>
						No tickets yet
					</p>
					<p
						className="mt-1 text-xs"
						style={{ color: "var(--wayfare-text-secondary)" }}
					>
						Your purchased tickets will appear here.
					</p>
					<Button variant="primary" as={Link} to="/" className="mt-4">
						Search for tickets
					</Button>
				</div>
			</PageShell>
		);
	}

	return (
		<PageShell
			title="My tickets"
			subtitle={`${packages.length} ticket${packages.length !== 1 ? "s" : ""}`}
		>
			<div className="mx-auto max-w-xl">
				<div className="flex flex-col gap-3">
					{packages.map((pkg) => (
						<TicketCard key={pkg.packageId} pkg={pkg} />
					))}
				</div>
			</div>
		</PageShell>
	);
}
