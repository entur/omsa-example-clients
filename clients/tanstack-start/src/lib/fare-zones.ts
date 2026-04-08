import rawZones from "../assets/fare-zones.json";

export interface FareZone {
	id: string;
	name: string;
	operator: string;
	operatorName: string;
	tariffZoneId?: string;
}

const OPERATOR_NAMES: Record<string, string> = {
	AKT: "Agder",
	ATB: "AtB (Trondheim)",
	BRA: "Brakar",
	FIN: "Finnmark",
	INN: "Innlandstrafikk",
	KOL: "Kolumbus",
	MOR: "Møre og Romsdal",
	NOR: "Nordland",
	OST: "Østfold",
	RUT: "Ruter",
	SKY: "Skyss",
	TEL: "Telemark",
	TRO: "Troms",
	VKT: "Vestfold Telemark",
};

type RawZone = {
	id: string;
	name: { value: string };
	keyList?: {
		keyValue?: { key: string; value: string }[];
	};
};

export const fareZones: FareZone[] = (rawZones as RawZone[]).map((z) => {
	const operator = z.id.split(":")[0];
	const tzMapping = z.keyList?.keyValue?.find((kv) => kv.key === "tzMapping");
	return {
		id: z.id,
		name: z.name.value,
		operator,
		operatorName: OPERATOR_NAMES[operator] ?? operator,
		tariffZoneId: tzMapping?.value,
	};
});

export function searchFareZones(query: string): FareZone[] {
	const q = query.trim().toLowerCase();
	if (!q) return [];
	return fareZones
		.filter(
			(z) =>
				z.name.toLowerCase().includes(q) ||
				z.operatorName.toLowerCase().includes(q) ||
				z.id.toLowerCase().includes(q),
		)
		.slice(0, 12);
}
