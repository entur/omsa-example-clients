import { createFileRoute } from "@tanstack/react-router";
import { useState } from "react";
import PageShell from "../components/layout/PageShell";
import { clearPackages, getPackages } from "../lib/ticket-storage";

export const Route = createFileRoute("/settings")({ component: SettingsPage });

function SettingsPage() {
	const [cleared, setCleared] = useState(false);
	const count = getPackages().length;

	function handleClear() {
		if (!confirm(`Delete ${count} saved ticket${count !== 1 ? "s" : ""}?`))
			return;
		clearPackages();
		setCleared(true);
	}

	return (
		<PageShell title="Settings">
			<div className="mx-auto max-w-lg">
				<section
					className="rounded-xl p-5"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					<h2
						className="mb-4 text-sm font-semibold"
						style={{ color: "var(--wayfare-text)" }}
					>
						Ticket wallet
					</h2>

					<div className="flex items-center justify-between">
						<div>
							<p
								className="text-sm"
								style={{ color: "var(--wayfare-text)", margin: 0 }}
							>
								Saved tickets
							</p>
							<p
								className="text-xs"
								style={{ color: "var(--wayfare-text-secondary)", margin: 0 }}
							>
								{cleared ? 0 : count} ticket{count !== 1 ? "s" : ""} stored
								locally
							</p>
						</div>
						<button
							type="button"
							onClick={handleClear}
							disabled={cleared || count === 0}
							className="rounded-lg px-3 py-1.5 text-xs font-semibold"
							style={{
								background: "rgba(233,0,55,0.08)",
								border: "1px solid rgba(233,0,55,0.2)",
								color: "var(--wayfare-primary)",
								cursor: cleared || count === 0 ? "not-allowed" : "pointer",
								opacity: cleared || count === 0 ? 0.5 : 1,
							}}
						>
							{cleared ? "Cleared" : "Clear history"}
						</button>
					</div>
				</section>

				<section
					className="mt-4 rounded-xl p-5"
					style={{
						background: "var(--wayfare-surface-strong)",
						border: "1px solid var(--wayfare-line)",
					}}
				>
					<h2
						className="mb-3 text-sm font-semibold"
						style={{ color: "var(--wayfare-text)" }}
					>
						About
					</h2>
					<dl className="space-y-2 text-sm">
						<div className="flex justify-between">
							<dt style={{ color: "var(--wayfare-text-secondary)" }}>App</dt>
							<dd style={{ color: "var(--wayfare-text)", fontWeight: 600 }}>
								Wayfare
							</dd>
						</div>
						<div className="flex justify-between">
							<dt style={{ color: "var(--wayfare-text-secondary)" }}>API</dt>
							<dd style={{ color: "var(--wayfare-text)" }}>OMSA v1 (dev)</dd>
						</div>
						<div className="flex justify-between">
							<dt style={{ color: "var(--wayfare-text-secondary)" }}>Stack</dt>
							<dd style={{ color: "var(--wayfare-text)" }}>
								TanStack Start + Entur DS
							</dd>
						</div>
					</dl>
				</section>
			</div>
		</PageShell>
	);
}
