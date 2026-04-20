export interface PlaceReference {
	placeId: string;
	name?: string;
}

export interface AmountOfMoney {
	amount: number;
	currencyCode?: string;
}

export interface Link {
	href: string;
	rel: string;
	type?: string;
	title?: string;
}
