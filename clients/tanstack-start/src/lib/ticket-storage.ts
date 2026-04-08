import type { StoredPackage } from "../types/documents";

const STORAGE_KEY = "wayfare_tickets";

export function savePackage(pkg: StoredPackage): void {
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
	const updated = getPackages().filter((p) => p.packageId !== id);
	try {
		localStorage.setItem(STORAGE_KEY, JSON.stringify(updated));
	} catch {
		// ignore
	}
}

export function clearPackages(): void {
	try {
		localStorage.removeItem(STORAGE_KEY);
	} catch {
		// ignore
	}
}
