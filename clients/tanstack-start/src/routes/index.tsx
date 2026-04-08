import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { Button } from "@entur/button";
import { DatePicker, TimePicker } from "@entur/datepicker";
import { SegmentedControl } from "@entur/form";
import { GridContainer, GridItem } from "@entur/grid";
import {
	type CalendarDate,
	type Time,
	getLocalTimeZone,
	parseDate,
	parseTime,
	today,
} from "@internationalized/date";
import { ClientOnly } from "@tanstack/react-router";
import PageShell from "../components/layout/PageShell";
import LocationSearch from "../components/search/LocationSearch";
import TravelerPicker from "../components/search/TravelerPicker";
import ZoneSearch from "../components/search/ZoneSearch";
import { SearchFormProvider, useSearchForm } from "../context/search-form";
import { useSearchOffers } from "../hooks/use-search-offers";

function toCalendarDate(iso: string): CalendarDate | null {
	if (!iso) return null;
	try {
		return parseDate(iso.slice(0, 10));
	} catch {
		return null;
	}
}

function toTime(iso: string): Time | null {
	if (!iso || iso.length < 16) return null;
	try {
		return parseTime(iso.slice(11, 16));
	} catch {
		return null;
	}
}

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

	function handleDateChange(date: CalendarDate | null) {
		if (!date) return;
		const time = toTime(state.travelDate);
		const timeStr = time
			? `${String(time.hour).padStart(2, "0")}:${String(time.minute).padStart(2, "0")}`
			: "00:00";
		dispatch({ type: "SET_TRAVEL_DATE", payload: `${date.toString()}T${timeStr}` });
	}

	function handleTimeChange(time: Time | null) {
		if (!time) return;
		const date = toCalendarDate(state.travelDate);
		if (!date) return;
		dispatch({
			type: "SET_TRAVEL_DATE",
			payload: `${date.toString()}T${String(time.hour).padStart(2, "0")}:${String(time.minute).padStart(2, "0")}`,
		});
	}

	return (
		<PageShell
			title="Where are you going?"
			subtitle="Plan your next trip in Norway"
		>
			<form
				onSubmit={handleSearch}
				className="rise-in mx-auto max-w-xl rounded-lg p-6"
				style={{
					background: "var(--wayfare-surface-strong)",
					border: "1px solid var(--wayfare-line)",
				}}
			>
				<GridContainer spacing="small">
				{/* Search type toggle */}
				<GridItem small={12}>
					<ClientOnly
						fallback={<div className="h-10 w-full" aria-hidden="true" />}
					>
						<SegmentedControl
							value={state.searchType}
							onChange={(value) => {
								if (value === "zone" || value === "stop") {
									dispatch({ type: "SET_SEARCH_TYPE", payload: value });
								}
							}}
						>
							<SegmentedControl.Item value="zone">
								Zone to Zone
							</SegmentedControl.Item>
							<SegmentedControl.Item value="stop">
								Stop to Stop
							</SegmentedControl.Item>
						</SegmentedControl>
					</ClientOnly>
				</GridItem>

				{/* Location inputs */}
				{state.searchType === "zone" ? (
					<>
						<GridItem small={12} medium={6}>
							<ZoneSearch
								label="From"
								value={state.from}
								placeholder="Search departure zone…"
								onChange={(z) => dispatch({ type: "SET_FROM", payload: z })}
							/>
						</GridItem>
						<GridItem small={12} medium={6}>
							<ZoneSearch
								label="To"
								value={state.to}
								placeholder="Search destination zone…"
								onChange={(z) => dispatch({ type: "SET_TO", payload: z })}
							/>
						</GridItem>
					</>
				) : (
					<>
						<GridItem small={12} medium={6}>
							<LocationSearch
								label="From"
								value={state.from}
								placeholder="Search departure stop…"
								onChange={(p) => dispatch({ type: "SET_FROM", payload: p })}
							/>
						</GridItem>
						<GridItem small={12} medium={6}>
							<LocationSearch
								label="To"
								value={state.to}
								placeholder="Search destination stop…"
								onChange={(p) => dispatch({ type: "SET_TO", payload: p })}
							/>
						</GridItem>
					</>
				)}

				{/* Date / Time pickers */}
				<GridItem small={12} medium={6}>
					<ClientOnly
						fallback={<div className="h-14 w-full" aria-hidden="true" />}
					>
						<DatePicker
							className="w-full"
							label="Departure date"
							selectedDate={toCalendarDate(state.travelDate)}
							onChange={handleDateChange}
							minDate={today(getLocalTimeZone())}
							disableModal
						/>
					</ClientOnly>
				</GridItem>
				<GridItem small={12} medium={6}>
					<ClientOnly
						fallback={<div className="h-14 w-full" aria-hidden="true" />}
					>
						<TimePicker
							className="w-full"
							label="Departure time"
							selectedTime={toTime(state.travelDate)}
							onChange={handleTimeChange}
							forcedReturnType="Time"
						/>
					</ClientOnly>
				</GridItem>

				{/* Traveler picker */}
				<GridItem small={12}>
					<ClientOnly
						fallback={<div className="h-12 w-full" aria-hidden="true" />}
					>
						<TravelerPicker
							travelers={state.travelers}
							onChange={(t) => dispatch({ type: "SET_TRAVELERS", payload: t })}
						/>
					</ClientOnly>
				</GridItem>

				{/* Error message */}
				{error && (
					<GridItem small={12}>
						<p
							className="rounded-lg px-3 py-2 text-sm"
							style={{
								background: "rgba(233,0,55,0.08)",
								color: "var(--wayfare-primary)",
							}}
						>
							{error.message}
						</p>
					</GridItem>
				)}

				{/* Submit */}
				<GridItem small={12}>
					<Button
						type="submit"
						variant="primary"
						width="fluid"
						disabled={!canSearch}
						loading={isPending}
					>
						Search offers
					</Button>
				</GridItem>
			</GridContainer>
			</form>
		</PageShell>
	);
}
