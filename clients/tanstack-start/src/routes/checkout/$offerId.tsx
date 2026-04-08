import { createFileRoute, Link } from "@tanstack/react-router";
import { useState } from "react";
import PaymentMethodPicker from "../../components/checkout/PaymentMethodPicker";
import PurchaseProgress from "../../components/checkout/PurchaseProgress";
import PurchaseSuccess from "../../components/checkout/PurchaseSuccess";
import PageShell from "../../components/layout/PageShell";
import {
	PurchaseFlowProvider,
	usePurchaseFlow,
} from "../../context/purchase-flow";
import { useConfirmPackage, usePurchaseOffers } from "../../hooks/use-purchase";
import { savePackage } from "../../lib/ticket-storage";
import type { Offer, OfferCollection } from "../../types/search";

export const Route = createFileRoute("/checkout/$offerId")({
	component: CheckoutPage,
});

function CheckoutPage() {
	return (
		<PurchaseFlowProvider>
			<CheckoutScreen />
		</PurchaseFlowProvider>
	);
}

function CheckoutScreen() {
	const { offerId } = Route.useParams();
	const { state, dispatch } = usePurchaseFlow();
	const [paymentMethod, setPaymentMethod] = useState<string | null>(null);

	const purchaseMutation = usePurchaseOffers();
	const confirmMutation = useConfirmPackage();

	let offer: Offer | null = null;
	try {
		const raw = sessionStorage.getItem("offerCollection");
		if (raw) {
			const col = JSON.parse(raw) as OfferCollection;
			offer = col.offers?.find((o) => o.id === offerId) ?? null;
		}
	} catch {
		// ignore
	}

	async function handlePurchase() {
		if (!paymentMethod) return;
		dispatch({ type: "START_PURCHASE" });
		try {
			const result = await purchaseMutation.mutateAsync({
				inputs: { type: "purchase_offers", offerIds: [offerId] },
			});
			const packageId = result.id ?? "";
			dispatch({
				type: "PURCHASE_DONE",
				packageId,
				paymentSession: { id: packageId },
			});
			dispatch({ type: "CONFIRMING" });
			const confirmed = await confirmMutation.mutateAsync({
				inputs: { type: "package", packageId },
			});
			savePackage({
				packageId,
				savedAt: new Date().toISOString(),
				status: confirmed.status ?? "CONFIRMED",
				price: {
					amount: confirmed.price?.amount ?? 0,
					currencyCode: confirmed.price?.currencyCode,
				},
				offerIds: [offerId],
			});
			dispatch({ type: "SUCCESS" });
		} catch (err) {
			dispatch({
				type: "FAILED",
				error: err instanceof Error ? err.message : "Purchase failed",
			});
		}
	}

	if (state.flowState === "success" && state.packageId) {
		return (
			<PageShell>
				<PurchaseSuccess packageId={state.packageId} />
			</PageShell>
		);
	}

	const product = offer?.properties?.products?.[0];
	const price = offer?.properties?.price;
	const isProcessing = [
		"purchasing",
		"paying",
		"capturing",
		"confirming",
	].includes(state.flowState);

	return (
		<PageShell title="Checkout" subtitle="Review your order and pay">
			<div className="mx-auto max-w-xl">
				{isProcessing && (
					<div className="mb-6">
						<PurchaseProgress flowState={state.flowState} />
					</div>
				)}

				<div
					className="mb-4 rounded-xl p-4"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					<p
						className="text-xs font-semibold uppercase tracking-wide"
						style={{ color: "var(--wayfare-text-secondary)" }}
					>
						Your offer
					</p>
					<div className="mt-2 flex items-center justify-between">
						<p
							className="text-sm font-semibold"
							style={{ color: "var(--wayfare-text)", margin: 0 }}
						>
							{product?.productName ?? "Travel Offer"}
						</p>
						{price && (
							<p
								className="text-base font-bold"
								style={{ color: "var(--wayfare-primary)", margin: 0 }}
							>
								{price.currencyCode ?? "NOK"} {price.amount.toFixed(2)}
							</p>
						)}
					</div>
				</div>

				<div
					className="mb-6 rounded-xl p-4"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					<PaymentMethodPicker
						selected={paymentMethod}
						onSelect={setPaymentMethod}
					/>
				</div>

				{state.error && (
					<p
						className="mb-4 rounded-lg px-3 py-2 text-sm"
						style={{
							background: "rgba(233,0,55,0.08)",
							color: "var(--wayfare-primary)",
						}}
					>
						{state.error}
					</p>
				)}

				<div className="flex gap-3">
					<Link
						to="/offers"
						className="flex-1 rounded-xl py-3 text-center text-sm font-semibold no-underline"
						style={{
							background: "var(--wayfare-surface-strong)",
							border: "1px solid var(--wayfare-line)",
							color: "var(--wayfare-text)",
						}}
					>
						Back
					</Link>
					<button
						type="button"
						onClick={handlePurchase}
						disabled={!paymentMethod || isProcessing}
						className="flex-1 rounded-xl py-3 text-sm font-bold transition"
						style={{
							background:
								paymentMethod && !isProcessing
									? "var(--wayfare-primary)"
									: "var(--wayfare-line)",
							color:
								paymentMethod && !isProcessing
									? "#fff"
									: "var(--wayfare-text-secondary)",
							border: "none",
							cursor:
								paymentMethod && !isProcessing ? "pointer" : "not-allowed",
						}}
					>
						{isProcessing ? "Processing…" : "Confirm & pay"}
					</button>
				</div>
			</div>
		</PageShell>
	);
}
