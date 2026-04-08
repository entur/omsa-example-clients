import { createFileRoute, useNavigate } from "@tanstack/react-router";
import PageShell from "../components/layout/PageShell";
import DepartureTimePicker from "../components/search/DepartureTimePicker";
import LocationSearch from "../components/search/LocationSearch";
import TravelerPicker from "../components/search/TravelerPicker";
import ZoneSelector from "../components/search/ZoneSelector";
import { SearchFormProvider, useSearchForm } from "../context/search-form";
import { useSearchOffers } from "../hooks/use-search-offers";

export const Route = createFileRoute("/")({ component: SearchPage });

function SearchPage() {
	return (
		<SearchFormProvider>
			<SearchScreen />
		</SearchFormProvider>
	);
}

function SearchScreen() {
	const { state, dispatch } = useSearchForm();
	const navigate = useNavigate();
	const { mutateAsync, isPending, error } = useSearchOffers();

	async function handleSearch(e: React.FormEvent) {
		e.preventDefault();
		if (!state.from || !state.to || state.travelers.length === 0) return;

		const travellers = state.travelers.flatMap((t, i) =>
			Array.from({ length: t.count }, (_, j) => ({
				id: `t${i}_${j}`,
				type: "individual_traveller" as const,
				age:
					t.minAge ??
					(t.ageGroup === "ADULT"
						? 30
						: t.ageGroup === "CHILD"
							? 10
							: t.ageGroup === "SENIOR"
								? 70
								: 16),
			})),
		);

		const result = await mutateAsync({
			inputs: {
				type: "search_offer",
				travellers,
				specification: {
					from: state.from,
					to: state.to,
					startTime: new Date(state.travelDate).toISOString(),
				},
			},
		});

		sessionStorage.setItem("offerCollection", JSON.stringify(result));
		sessionStorage.setItem(
			"searchContext",
			JSON.stringify({
				from: state.from,
				to: state.to,
				travelDate: state.travelDate,
				searchType: state.searchType,
			}),
		);
		navigate({ to: "/offers" });
	}

	const canSearch = state.from && state.to && state.travelers.length > 0;

	return (
		<PageShell
			title="Where are you going?"
			subtitle="Search for travel offers across Nord-Jæren"
		>
			<form
				onSubmit={handleSearch}
				className="rise-in mx-auto max-w-xl rounded-2xl p-6 shadow-sm"
				style={{
					background: "var(--wayfare-surface-strong)",
					border: "1px solid var(--wayfare-line)",
				}}
			>
				<div className="flex flex-col gap-4">
					{/* Search type toggle */}
					<div
						className="flex overflow-hidden rounded-lg"
						style={{ border: "1px solid var(--wayfare-line)" }}
					>
						{(["zone", "stop"] as const).map((type) => (
							<button
								key={type}
								type="button"
								onClick={() =>
									dispatch({ type: "SET_SEARCH_TYPE", payload: type })
								}
								className="flex-1 py-2 text-sm font-medium transition-colors"
								style={{
									background:
										state.searchType === type
											? "var(--wayfare-primary)"
											: "transparent",
									color:
										state.searchType === type
											? "#fff"
											: "var(--wayfare-text-secondary)",
									border: "none",
									cursor: "pointer",
								}}
							>
								{type === "zone" ? "Zone to Zone" : "Stop to Stop"}
							</button>
						))}
					</div>

					{/* Location inputs */}
					{state.searchType === "zone" ? (
						<ZoneSelector
							from={state.from}
							to={state.to}
							onFromChange={(z) => dispatch({ type: "SET_FROM", payload: z })}
							onToChange={(z) => dispatch({ type: "SET_TO", payload: z })}
						/>
					) : (
						<div className="grid gap-3 sm:grid-cols-2">
							<LocationSearch
								id="stop-from"
								label="From"
								value={state.from}
								placeholder="Search departure stop…"
								onChange={(p) => dispatch({ type: "SET_FROM", payload: p })}
							/>
							<LocationSearch
								id="stop-to"
								label="To"
								value={state.to}
								placeholder="Search destination stop…"
								onChange={(p) => dispatch({ type: "SET_TO", payload: p })}
							/>
						</div>
					)}

					<DepartureTimePicker
						value={state.travelDate}
						onChange={(v) => dispatch({ type: "SET_TRAVEL_DATE", payload: v })}
					/>

					<TravelerPicker
						travelers={state.travelers}
						onChange={(t) => dispatch({ type: "SET_TRAVELERS", payload: t })}
					/>

					{error && (
						<p
							className="rounded-lg px-3 py-2 text-sm"
							style={{
								background: "rgba(233,0,55,0.08)",
								color: "var(--wayfare-primary)",
							}}
						>
							{error.message}
						</p>
					)}

					<button
						type="submit"
						disabled={isPending || !canSearch}
						className="mt-1 w-full rounded-xl py-3 text-sm font-bold transition"
						style={{
							background: canSearch
								? "var(--wayfare-primary)"
								: "var(--wayfare-line)",
							color: canSearch ? "#fff" : "var(--wayfare-text-secondary)",
							border: "none",
							cursor: canSearch ? "pointer" : "not-allowed",
						}}
					>
						{isPending ? "Searching…" : "Search offers"}
					</button>
				</div>
			</form>
		</PageShell>
	);
}
