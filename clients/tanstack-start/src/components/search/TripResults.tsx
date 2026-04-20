import { TravelTag } from "@entur/travel";
import React from "react";
import type {
	OtpTransportMode,
	TripLeg,
	TripPattern,
} from "../../types/trip-planner";

type Transport =
	| "metro"
	| "bus"
	| "plane"
	| "helicopter"
	| "tram"
	| "funicular"
	| "cableway"
	| "taxi"
	| "bicycle"
	| "walk"
	| "train"
	| "ferry"
	| "carferry"
	| "mobility"
	| "airportLinkBus"
	| "airportLinkRail"
	| "snowcoach"
	| "rail"
	| "water"
	| "air"
	| "none";

const MODE_TO_TRANSPORT: Partial<Record<OtpTransportMode, Transport>> = {
	bus: "bus",
	coach: "bus",
	rail: "train",
	tram: "tram",
	metro: "metro",
	water: "water",
	ferry: "ferry",
	air: "air",
	bicycle: "bicycle",
	car: "taxi",
	foot: "walk",
};

function formatTime(iso: string): string {
	return new Date(iso).toLocaleTimeString("no-NO", {
		hour: "2-digit",
		minute: "2-digit",
		hour12: false,
	});
}

function formatDuration(seconds: number): string {
	const h = Math.floor(seconds / 3600);
	const m = Math.floor((seconds % 3600) / 60);
	return h > 0 ? `${h}h ${m}min` : `${m}min`;
}

function hasTransitLegs(pattern: TripPattern): boolean {
	return pattern.legs.some((l) => l.serviceJourney != null);
}

function getLegKey(leg: TripLeg): string {
	return `${leg.serviceJourney?.id ?? leg.mode}-${leg.expectedStartTime}-${leg.expectedEndTime}`;
}

function getPatternKey(pattern: TripPattern): string {
	return [
		pattern.expectedStartTime,
		pattern.expectedEndTime,
		...pattern.legs.map((leg) => getLegKey(leg)),
	].join("|");
}

function TransitLegPill({ leg }: { leg: TripLeg }) {
	const transport = MODE_TO_TRANSPORT[leg.mode];
	if (!transport) return null;
	const lineCode = leg.line?.publicCode ?? undefined;
	return <TravelTag transport={transport} details={lineCode} />;
}

interface TripResultsProps {
	patterns: TripPattern[];
	onSelect: (pattern: TripPattern) => void;
	isPending: boolean;
}

export default function TripResults({
	patterns,
	onSelect,
	isPending,
}: TripResultsProps) {
	const transitPatterns = patterns.filter(hasTransitLegs);

	if (transitPatterns.length === 0) {
		return (
			<p
				className="text-center text-sm"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				No trip options found. Try a different time or route.
			</p>
		);
	}

	return (
		<div className="flex flex-col gap-2">
			<p
				className="text-xs font-medium"
				style={{ color: "var(--wayfare-text-secondary)" }}
			>
				Select a trip to search for tickets
			</p>
			{transitPatterns.map((pattern) => {
				const transitLegs = pattern.legs.filter(
					(l) => l.serviceJourney != null,
				);
				return (
					<button
						key={getPatternKey(pattern)}
						type="button"
						disabled={isPending}
						onClick={() => onSelect(pattern)}
						className="w-full rounded-xl border p-4 text-left transition-all hover:shadow-md"
						style={{
							background: "var(--wayfare-surface-strong)",
							borderColor: "var(--wayfare-line)",
							opacity: isPending ? 0.6 : 1,
							cursor: isPending ? "not-allowed" : "pointer",
						}}
					>
						<div className="flex items-center justify-between gap-2">
							<span
								className="text-sm font-semibold"
								style={{ color: "var(--wayfare-text)" }}
							>
								{formatTime(pattern.expectedStartTime)} →{" "}
								{formatTime(pattern.expectedEndTime)}
							</span>
							<span
								className="shrink-0 text-xs"
								style={{ color: "var(--wayfare-text-secondary)" }}
							>
								{formatDuration(pattern.duration)}
							</span>
						</div>
						<div className="mt-2 flex flex-wrap items-center gap-1">
							{transitLegs.map((leg, j) => (
								<React.Fragment key={getLegKey(leg)}>
									<TransitLegPill leg={leg} />
									{j < transitLegs.length - 1 && (
										<span
											className="text-xs"
											style={{ color: "var(--wayfare-text-secondary)" }}
										>
											→
										</span>
									)}
								</React.Fragment>
							))}
						</div>
					</button>
				);
			})}
		</div>
	);
}
