import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { useEffect } from "react";
import PageShell from "../components/layout/PageShell";
import { useCaptureTransaction } from "../hooks/use-payments";
import { useConfirmPackage } from "../hooks/use-purchase";
import { savePackage } from "../lib/ticket-storage";

export const Route = createFileRoute("/payment-return")({
	validateSearch: (search: Record<string, unknown>) => ({
		packageId: search.packageId as string | undefined,
		enturPaymentId: search.enturPaymentId as string | undefined,
		enturTransactionId: search.enturTransactionId as string | undefined,
	}),
	component: PaymentReturnPage,
});

function PaymentReturnPage() {
	const { packageId, enturPaymentId, enturTransactionId } = Route.useSearch();
	const navigate = useNavigate();
	const captureMutation = useCaptureTransaction();
	const confirmMutation = useConfirmPackage();

	useEffect(() => {
		if (!packageId) {
			navigate({ to: "/" });
			return;
		}
		const resolvedPackageId = packageId;

		async function complete() {
			try {
				if (enturPaymentId && enturTransactionId) {
					await captureMutation.mutateAsync({
						paymentId: enturPaymentId,
						transactionId: enturTransactionId,
					});
				}
				const confirmed = await confirmMutation.mutateAsync({
					inputs: { type: "package_input", packageId: resolvedPackageId },
				});
				savePackage({
					packageId: resolvedPackageId,
					savedAt: new Date().toISOString(),
					status: confirmed.status ?? "CONFIRMED",
					price: {
						amount: confirmed.price?.amount ?? 0,
						currencyCode: confirmed.price?.currencyCode,
					},
				});
				navigate({
					to: "/tickets/$packageId",
					params: { packageId: resolvedPackageId },
				});
			} catch {
				navigate({ to: "/" });
			}
		}

		complete();
	}, [
		packageId,
		captureMutation.mutateAsync,
		confirmMutation.mutateAsync,
		navigate,
		enturPaymentId,
		enturTransactionId,
	]);

	return (
		<PageShell title="Completing your purchase">
			<div className="flex flex-col items-center py-12 text-center">
				<div
					className="mb-4 h-10 w-10 animate-spin rounded-full border-4 border-t-transparent"
					style={{
						borderColor: "var(--wayfare-line)",
						borderTopColor: "var(--wayfare-primary)",
					}}
				/>
				<p
					className="text-sm"
					style={{ color: "var(--wayfare-text-secondary)" }}
				>
					Completing your purchase…
				</p>
			</div>
		</PageShell>
	);
}
