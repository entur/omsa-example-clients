import { CardIcon, LeftArrowIcon } from "@entur/icons";
import { createFileRoute, Link } from "@tanstack/react-router";
import { useEffect, useState } from "react";
import PaymentMethodPicker from "../../components/checkout/PaymentMethodPicker";
import PurchaseProgress from "../../components/checkout/PurchaseProgress";
import PurchaseSuccess from "../../components/checkout/PurchaseSuccess";
import PageShell from "../../components/layout/PageShell";
import Button from "../../components/ui/Button";
import {
	PurchaseFlowProvider,
	usePurchaseFlow,
} from "../../context/purchase-flow";
import {
	useCreatePayment,
	useStartTerminalSession,
} from "../../hooks/use-payments";
import { usePurchaseOffers } from "../../hooks/use-purchase";
import { readSearchSession } from "../../lib/search-session";
import type { PaymentType } from "../../types/purchase";
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
	const [paymentMethod, setPaymentMethod] = useState<PaymentType | null>(null);
	const [hydrated, setHydrated] = useState(false);
	const [offerCollection, setOfferCollection] =
		useState<OfferCollection | null>(null);

	const purchaseMutation = usePurchaseOffers();
	const createPaymentMutation = useCreatePayment();
	const startTerminalMutation = useStartTerminalSession();

	useEffect(() => {
		const session = readSearchSession();
		setOfferCollection(session.collection);
		setHydrated(true);
	}, []);

	const offer: Offer | null =
		offerCollection?.offers?.find((candidate) => candidate.id === offerId) ??
		null;

	async function handlePurchase() {
		if (!paymentMethod) return;
		dispatch({ type: "START_PURCHASE" });
		try {
			// Step 1: OMSA purchase-offers
			const purchased = await purchaseMutation.mutateAsync({
				inputs: { type: "purchase_offers", offerIds: [offerId] },
			});
			const packageId = purchased.id ?? "";
			dispatch({ type: "PURCHASE_DONE", packageId });

			// Step 2: Entur Sales create payment
			const amount = purchased.price?.amount?.toFixed(2) ?? "0.00";
			const currency = purchased.price?.currencyCode ?? "NOK";
			const payment = await createPaymentMutation.mutateAsync({
				orderId: packageId,
				orderVersion: purchased.orderVersion ?? 1,
				totalAmount: amount,
				transaction: {
					amount,
					currency,
					paymentType: paymentMethod,
					isImport: false,
					paymentTypeGroup:
						paymentMethod === "VIPPS" ? "WALLET" : "PAYMENTCARD",
				},
			});
			const paymentId = String(payment.paymentId ?? "");
			const transactionId = String(
				payment.transactionHistory?.[0]?.transactionId ?? "",
			);

			// Step 3: Start terminal session — redirectUrl brings us back after payment
			// Use entur-prefixed param names to avoid collision with Nets' own
			// transactionId/paymentId query params it appends on redirect.
			const redirectUrl = `${window.location.origin}/payment-return?packageId=${packageId}&enturPaymentId=${paymentId}&enturTransactionId=${transactionId}`;
			const terminal = await startTerminalMutation.mutateAsync({
				paymentId,
				transactionId,
				redirectUrl,
				terminalLanguage: "en_GB",
			});

			// Step 4: Redirect user to Nets terminal
			window.location.href = terminal.terminalUri ?? "";
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

	if (!hydrated) {
		return (
			<PageShell title="Checkout" subtitle="Review your order and pay">
				<p style={{ color: "var(--wayfare-text-secondary)" }}>Loading…</p>
			</PageShell>
		);
	}

	return (
		<PageShell title="Checkout" subtitle="Review your order and pay">
			<div className="mx-auto max-w-xl">
				{isProcessing && (
					<div className="mb-6">
						<PurchaseProgress flowState={state.flowState} />
					</div>
				)}

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
					className="mb-6 rounded-lg p-4"
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
						className="inline-flex flex-1 items-center justify-center gap-1.5 rounded-xl border px-5 py-2.5 text-sm font-semibold no-underline transition-colors"
						style={{
							borderColor: "var(--wayfare-line)",
							color: "var(--wayfare-text)",
						}}
					>
						<LeftArrowIcon aria-hidden="true" />
						Back
					</Link>
					<Button
						variant="primary"
						className="flex-1"
						disabled={!paymentMethod || isProcessing}
						loading={isProcessing}
						onClick={handlePurchase}
					>
						Confirm & pay
						<CardIcon aria-hidden="true" />
					</Button>
				</div>
			</div>
		</PageShell>
	);
}
