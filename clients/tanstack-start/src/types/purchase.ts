import type { AmountOfMoney, Link } from "./common";

export interface PurchaseOffersInputs {
	type: "purchase_offers";
	offerIds: string[];
	timestamp?: string;
}

export interface PurchaseOffersRequest {
	inputs: PurchaseOffersInputs;
}

export interface PackageInput {
	type: "package";
	packageId: string;
	timestamp?: string;
}

export interface ConfirmPackageRequest {
	inputs: PackageInput;
}

export interface CancelPackageRequest {
	inputs: PackageInput;
}

export interface RefundOptionInput {
	type: "claim_refund_option" | "confirm_refund_option";
	optionId?: string;
}

export interface ClaimRefundRequest {
	inputs: RefundOptionInput;
}

export type PackageStatus =
	| "OFFER"
	| "CONFIRMED"
	| "CANCEL_PENDING"
	| "CANCELLED"
	| "EXCHANGED"
	| "EXPIRED"
	| "UNKNOWN";

export interface PackageLeg {
	id?: string;
	type?: string;
	from?: { placeId: string; name?: string };
	to?: { placeId: string; name?: string };
	startTime?: string;
	endTime?: string;
}

export interface ConfirmedPackage {
	type?: string;
	id?: string;
	status: PackageStatus;
	price: AmountOfMoney;
	links?: Link[];
}

export interface PaymentTransaction {
	amount: string;
	currency: string;
	paymentType: string;
}

export interface PaymentRequest {
	orderId: string;
	orderVersion: number;
	totalAmount: string;
	transaction: PaymentTransaction;
}

export interface TransactionStatus {
	id?: string;
	status?: string;
	amount?: string;
	currency?: string;
	paymentType?: string;
	redirectUrl?: string;
}

export interface PaymentSessionResult {
	id?: string;
	orderId?: string;
	transactions?: TransactionStatus[];
	links?: Link[];
}
