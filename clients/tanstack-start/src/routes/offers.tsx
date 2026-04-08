import { createFileRoute, Link, useNavigate } from "@tanstack/react-router";
import { useState } from "react";
import { TravelHeader } from "@entur/travel";
import OfferCard from "../components/checkout/OfferCard";
import PageShell from "../components/layout/PageShell";
import { PurchaseFlowProvider } from "../context/purchase-flow";
import type { SearchType } from "../context/search-form";
import type { PlaceReference } from "../types/common";
import type { Offer, OfferCollection } from "../types/search";

interface SearchContext {
	from: PlaceReference;
	to: PlaceReference;
	travelDate: string;
	searchType: SearchType;
}

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

	let collection: OfferCollection | null = null;
	let context: SearchContext | null = null;
	try {
		const raw = sessionStorage.getItem("offerCollection");
		if (raw) collection = JSON.parse(raw) as OfferCollection;
		const ctx = sessionStorage.getItem("searchContext");
		if (ctx) context = JSON.parse(ctx) as SearchContext;
	} catch {
		// ignore parse errors
	}

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
						className="mb-5 rounded-2xl p-4"
						style={{
							background: "var(--wayfare-surface-strong)",
							border: "1px solid var(--wayfare-line)",
						}}
					>
						<TravelHeader
							from={context.from.name ?? context.from.placeId}
							to={context.to.name ?? context.to.placeId}
							size="medium"
						/>
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
							key={offer.id}
							offer={offer}
							selected={selectedId === offer.id}
							onSelect={() => setSelectedId(offer.id ?? null)}
						/>
					))}
				</div>

				<div className="mt-6 flex gap-3">
					<Link
						to="/"
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
						onClick={handleContinue}
						disabled={!selectedId}
						className="flex-1 rounded-xl py-3 text-sm font-bold transition"
						style={{
							background: selectedId
								? "var(--wayfare-primary)"
								: "var(--wayfare-line)",
							color: selectedId ? "#fff" : "var(--wayfare-text-secondary)",
							border: "none",
							cursor: selectedId ? "pointer" : "not-allowed",
						}}
					>
						Continue to checkout
					</button>
				</div>
			</div>
		</PageShell>
	);
}
