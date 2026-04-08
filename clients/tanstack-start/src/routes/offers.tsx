import { LeftArrowIcon, RightArrowIcon } from "@entur/icons";
import { createFileRoute, Link, useNavigate } from "@tanstack/react-router";
import { useEffect, useState } from "react";
import OfferCard from "../components/checkout/OfferCard";
import PageShell from "../components/layout/PageShell";
import Button from "../components/ui/Button";
import { PurchaseFlowProvider } from "../context/purchase-flow";
import { readSearchSession, type SearchContext } from "../lib/search-session";
import type { Offer, OfferCollection } from "../types/search";

export const Route = createFileRoute("/offers")({ component: OffersPage });

function OffersPage() {
	return (
		<PurchaseFlowProvider>
			<OffersScreen />
		</PurchaseFlowProvider>
	);
}

function OffersScreen() {
	const navigate = useNavigate();
	const [selectedId, setSelectedId] = useState<string | null>(null);
	const [hydrated, setHydrated] = useState(false);
	const [collection, setCollection] = useState<OfferCollection | null>(null);
	const [context, setContext] = useState<SearchContext | null>(null);

	useEffect(() => {
		const session = readSearchSession();
		setCollection(session.collection);
		setContext(session.context);
		setHydrated(true);
	}, []);

	const offers: Offer[] = collection?.offers ?? [];

	const formattedDate = context?.travelDate
		? new Date(context.travelDate).toLocaleString("no-NO", {
				weekday: "short",
				day: "numeric",
				month: "short",
				hour: "2-digit",
				minute: "2-digit",
			})
		: null;

	function handleContinue() {
		if (!selectedId) return;
		navigate({ to: "/checkout/$offerId", params: { offerId: selectedId } });
	}

	if (!hydrated) {
		return (
			<PageShell title="Loading offers">
				<p style={{ color: "var(--wayfare-text-secondary)" }}>Loading…</p>
			</PageShell>
		);
	}

	if (offers.length === 0) {
		return (
			<PageShell title="No offers found">
				<div className="mt-8 text-center">
					<p style={{ color: "var(--wayfare-text-secondary)" }}>
						No travel offers were found for your search.
					</p>
					<Link
						to="/"
						className="mt-4 inline-block rounded-xl px-5 py-2.5 text-sm font-semibold no-underline"
						style={{ background: "var(--wayfare-primary)", color: "#fff" }}
					>
						Back to search
					</Link>
				</div>
			</PageShell>
		);
	}

	return (
		<PageShell
			title="Available offers"
			subtitle={`${offers.length} offer${offers.length !== 1 ? "s" : ""} found`}
		>
			<div className="mx-auto max-w-xl">
				{context && (
					<div
						className="mb-5 rounded-lg p-4"
						style={{
							background: "var(--wayfare-surface-strong)",
							border: "1px solid var(--wayfare-line)",
						}}
					>
						<div className="flex items-center gap-2">
							<span
								className="text-sm font-semibold"
								style={{ color: "var(--wayfare-text)" }}
							>
								{context.from.name ?? context.from.placeId}
							</span>
							<RightArrowIcon
								aria-hidden="true"
								style={{
									color: "var(--wayfare-text-secondary)",
									flexShrink: 0,
								}}
							/>
							<span
								className="text-sm font-semibold"
								style={{ color: "var(--wayfare-text)" }}
							>
								{context.to.name ?? context.to.placeId}
							</span>
						</div>
						{formattedDate && (
							<p
								className="mt-2 text-xs"
								style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
							>
								{formattedDate}
							</p>
						)}
					</div>
				)}

				<div className="flex flex-col gap-3">
					{offers.map((offer) => (
						<OfferCard
							key={
								offer.id ??
								`${offer.properties?.products?.[0]?.productName ?? "offer"}-${
									offer.properties?.price?.amount ?? "0"
								}`
							}
							offer={offer}
							selected={selectedId === offer.id}
							onSelect={() => {
								if (offer.id) {
									setSelectedId(offer.id);
								}
							}}
						/>
					))}
				</div>

				<div className="mt-6 flex gap-3">
					<Link
						to="/"
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
						disabled={!selectedId}
						onClick={handleContinue}
					>
						Continue to checkout
						<RightArrowIcon aria-hidden="true" />
					</Button>
				</div>
			</div>
		</PageShell>
	);
}
