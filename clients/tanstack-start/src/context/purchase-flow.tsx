import { createContext, useContext, useReducer } from "react";
import type { PaymentSessionResult } from "../types/purchase";

export type PurchaseFlowState =
	| "idle"
	| "offers_loaded"
	| "selected"
	| "purchasing"
	| "paying"
	| "capturing"
	| "confirming"
	| "success"
	| "failed";

interface PurchaseFlow {
	flowState: PurchaseFlowState;
	selectedOfferId: string | null;
	packageId: string | null;
	paymentSession: PaymentSessionResult | null;
	error: string | null;
}

type Action =
	| { type: "SELECT_OFFER"; offerId: string }
	| { type: "START_PURCHASE" }
	| {
			type: "PURCHASE_DONE";
			packageId: string;
			paymentSession?: PaymentSessionResult | null;
	  }
	| { type: "PAYMENT_STARTED" }
	| { type: "CAPTURING" }
	| { type: "CONFIRMING" }
	| { type: "SUCCESS" }
	| { type: "FAILED"; error: string }
	| { type: "RESET" };

const initialState: PurchaseFlow = {
	flowState: "idle",
	selectedOfferId: null,
	packageId: null,
	paymentSession: null,
	error: null,
};

function reducer(state: PurchaseFlow, action: Action): PurchaseFlow {
	switch (action.type) {
		case "SELECT_OFFER":
			return {
				...state,
				flowState: "selected",
				selectedOfferId: action.offerId,
			};
		case "START_PURCHASE":
			return { ...state, flowState: "purchasing", error: null };
		case "PURCHASE_DONE":
			return {
				...state,
				flowState: "paying",
				packageId: action.packageId,
				paymentSession: action.paymentSession,
			};
		case "PAYMENT_STARTED":
			return { ...state, flowState: "paying" };
		case "CAPTURING":
			return { ...state, flowState: "capturing" };
		case "CONFIRMING":
			return { ...state, flowState: "confirming" };
		case "SUCCESS":
			return { ...state, flowState: "success" };
		case "FAILED":
			return { ...state, flowState: "failed", error: action.error };
		case "RESET":
			return initialState;
		default:
			return state;
	}
}

const PurchaseFlowContext = createContext<{
	state: PurchaseFlow;
	dispatch: React.Dispatch<Action>;
} | null>(null);

export function PurchaseFlowProvider({
	children,
}: {
	children: React.ReactNode;
}) {
	const [state, dispatch] = useReducer(reducer, initialState);
	return (
		<PurchaseFlowContext.Provider value={{ state, dispatch }}>
			{children}
		</PurchaseFlowContext.Provider>
	);
}

export function usePurchaseFlow() {
	const ctx = useContext(PurchaseFlowContext);
	if (!ctx)
		throw new Error("usePurchaseFlow must be used within PurchaseFlowProvider");
	return ctx;
}
