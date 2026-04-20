import type { StoredPackage } from "../types/documents";

const STORAGE_KEY = "wayfare_tickets";

const isClient = typeof window !== "undefined";

export function savePackage(pkg: StoredPackage): void {
	if (!isClient) return;
	const existing = getPackages();
	const updated = [
		pkg,
		...existing.filter((p) => p.packageId !== pkg.packageId),
	];
	try {
		localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
	} catch {
		// storage may be full or unavailable
	}
}

export function getPackages(): StoredPackage[] {
	if (!isClient) return [];
	try {
		const raw = localStorage.getItem(STORAGE_KEY);
		if (!raw) return [];
		return JSON.parse(raw) as StoredPackage[];
	} catch {
		return [];
	}
}

export function getPackage(id: string): StoredPackage | undefined {
	return getPackages().find((p) => p.packageId === id);
}

export function removePackage(id: string): void {
	if (!isClient) return;
	const updated = getPackages().filter((p) => p.packageId !== id);
	try {
		localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
	} catch {
		// ignore
	}
}

export function clearPackages(): void {
	if (!isClient) return;
	try {
		localStorage.removeItem(STORAGE_KEY);
	} catch {
		// ignore
	}
}
