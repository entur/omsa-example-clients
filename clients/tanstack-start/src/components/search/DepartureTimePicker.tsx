import { type CalendarDateTime, DatePicker } from "@entur/datepicker";
import {
	getLocalTimeZone,
	parseDateTime,
	today,
} from "@internationalized/date";
import { ClientOnly } from "@tanstack/react-router";

interface DepartureTimePickerProps {
	value: string;
	onChange: (value: string) => void;
}

function toCalendarDateTime(iso: string): CalendarDateTime | null {
	if (!iso) return null;
	try {
		return parseDateTime(iso) as CalendarDateTime;
	} catch {
		return null;
	}
}

export default function DepartureTimePicker({
	value,
	onChange,
}: DepartureTimePickerProps) {
	return (
		<ClientOnly fallback={<div className="h-14 w-full" aria-hidden="true" />}>
			<DatePicker
				label="Departure"
				selectedDate={toCalendarDateTime(value)}
				onChange={(dt) => {
					if (dt) onChange(dt.toString().slice(0, 16));
				}}
				showTime
				minDate={today(getLocalTimeZone())}
				disableModal
			/>
		</ClientOnly>
	);
}
