import { createFileRoute } from "@tanstack/react-router";
import { useEffect, useState } from "react";
import PageShell from "../components/layout/PageShell";
import Button from "../components/ui/Button";
import { clearPackages, getPackages } from "../lib/ticket-storage";

export const Route = createFileRoute("/settings")({ component: SettingsPage });

function SettingsPage() {
	const [cleared, setCleared] = useState(false);
	const [count, setCount] = useState(0);

	useEffect(() => {
		setCount(getPackages().length);
	}, []);

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
					className="rounded-lg p-5"
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
						<Button
							variant="secondary"
							disabled={cleared || count === 0}
							onClick={handleClear}
						>
							{cleared ? "Cleared" : "Clear history"}
						</Button>
					</div>
				</section>

				<section
					className="mt-4 rounded-lg p-5"
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
							<dd style={{ color: "var(--wayfare-text)" }}>
								OMSA v1 (OMSA_ENV_MODE)
							</dd>
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
