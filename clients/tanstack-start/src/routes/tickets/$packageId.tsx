import { createFileRoute, Link, useNavigate } from "@tanstack/react-router";
import { Button } from "@entur/button";
import PageShell from "../../components/layout/PageShell";
import DocumentViewer from "../../components/tickets/DocumentViewer";
import {
	useRefundOptions,
	useTravelDocuments,
} from "../../hooks/use-documents";
import { useCancelPackage, useClaimRefund } from "../../hooks/use-purchase";
import { getPackage, removePackage } from "../../lib/ticket-storage";

export const Route = createFileRoute("/tickets/$packageId")({
	component: TicketDetailPage,
});

function TicketDetailPage() {
	const { packageId } = Route.useParams();
	const navigate = useNavigate();

	const pkg = getPackage(packageId);
	const { data: docCollection, isLoading: docsLoading } =
		useTravelDocuments(packageId);
	const { data: refundCollection } = useRefundOptions(packageId);
	const cancelMutation = useCancelPackage();
	const claimRefundMutation = useClaimRefund();

	async function handleCancel() {
		if (!confirm("Are you sure you want to cancel this ticket?")) return;
		await cancelMutation.mutateAsync({
			inputs: { type: "package", packageId },
		});
		removePackage(packageId);
		navigate({ to: "/tickets" });
	}

	async function handleClaimRefund(optionId: string) {
		await claimRefundMutation.mutateAsync({
			inputs: { type: "claim_refund_option", optionId },
		});
	}

	if (!pkg) {
		return (
			<PageShell title="Ticket not found">
				<div className="mt-8 text-center">
					<Link
						to="/tickets"
						className="text-sm font-medium"
						style={{ color: "var(--wayfare-primary)" }}
					>
						← Back to tickets
					</Link>
				</div>
			</PageShell>
		);
	}

	const documents = docCollection?.travelDocuments ?? [];
	const refundOptions = refundCollection?.options ?? [];

	return (
		<PageShell title="Ticket details">
			<div className="mx-auto max-w-xl">
				<Link
					to="/tickets"
					className="mb-4 inline-block text-sm font-medium no-underline"
					style={{ color: "var(--wayfare-text-secondary)" }}
				>
					← My tickets
				</Link>

				<div
					className="mb-4 rounded-lg p-4"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					<p
						className="text-xs font-semibold uppercase tracking-wide"
						style={{ color: "var(--wayfare-text-secondary)" }}
					>
						Package
					</p>
					<p
						className="mt-1 font-mono text-sm"
						style={{ color: "var(--wayfare-text)" }}
					>
						{pkg.packageId}
					</p>
					<div className="mt-2 flex items-center justify-between">
						<span
							className="rounded-full px-2.5 py-0.5 text-xs font-semibold"
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
						<p
							className="text-sm font-bold"
							style={{ color: "var(--wayfare-primary)", margin: 0 }}
						>
							{pkg.price.currencyCode ?? "NOK"} {pkg.price.amount.toFixed(2)}
						</p>
					</div>
				</div>

				<div className="mb-4">
					<h2
						className="mb-3 text-sm font-semibold"
						style={{ color: "var(--wayfare-text)" }}
					>
						Travel documents
					</h2>
					{docsLoading ? (
						<p
							className="text-sm"
							style={{ color: "var(--wayfare-text-secondary)" }}
						>
							Loading…
						</p>
					) : (
						<DocumentViewer documents={documents} />
					)}
				</div>

				{refundOptions.length > 0 && (
					<div
						className="mb-4 rounded-xl p-4"
						style={{
							background: "var(--wayfare-surface-strong)",
							border: "1px solid var(--wayfare-line)",
						}}
					>
						<h2
							className="mb-3 text-sm font-semibold"
							style={{ color: "var(--wayfare-text)" }}
						>
							Refund options
						</h2>
						<div className="flex flex-col gap-2">
							{refundOptions.map((opt) => (
								<div key={opt.id} className="flex items-center justify-between">
									<p
										className="text-sm"
										style={{ color: "var(--wayfare-text)", margin: 0 }}
									>
										{opt.properties?.refundType ?? "Refund"}
										{opt.properties?.consequences?.[0]?.amount !==
											undefined && (
											<span
												className="ml-2 font-semibold"
												style={{ color: "var(--wayfare-primary)" }}
											>
												{opt.properties.consequences[0].currencyCode ?? "NOK"}{" "}
												{opt.properties.consequences[0].amount.toFixed(2)}
											</span>
										)}
									</p>
									<button
										type="button"
										onClick={() => opt.id && handleClaimRefund(opt.id)}
										className="rounded-lg px-3 py-1.5 text-xs font-semibold"
										style={{
											background: "var(--wayfare-accent-soft)",
											color: "var(--wayfare-primary)",
											border: "none",
											cursor: "pointer",
										}}
									>
										Claim
									</button>
								</div>
							))}
						</div>
					</div>
				)}

				<Button
					variant="negative"
					width="fluid"
					disabled={cancelMutation.isPending}
					loading={cancelMutation.isPending}
					onClick={handleCancel}
				>
					Cancel ticket
				</Button>
			</div>
		</PageShell>
	);
}
