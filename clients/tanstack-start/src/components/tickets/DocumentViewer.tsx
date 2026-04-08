import type { TravelDocumentItem } from "../../types/documents";

interface DocumentViewerProps {
	documents: TravelDocumentItem[];
}

export default function DocumentViewer({ documents }: DocumentViewerProps) {
	if (documents.length === 0) {
		return (
			<p className="text-sm" style={{ color: "var(--wayfare-text-secondary)" }}>
				No travel documents available yet.
			</p>
		);
	}

	return (
		<div className="flex flex-col gap-4">
			{documents.map((doc, i) => {
				const props = doc.properties;
				if (!props) return null;

				if (props.type === "binaryTicket") {
					return (
						<div
							key={doc.id ?? i}
							className="rounded-xl p-4"
							style={{
								background: "var(--wayfare-surface-strong)",
								border: "1px solid var(--wayfare-line)",
							}}
						>
							<p
								className="mb-2 text-xs font-semibold uppercase tracking-wide"
								style={{ color: "var(--wayfare-text-secondary)" }}
							>
								Travel document
							</p>
							<img
								src={`data:${props.contentType};base64,${props.base64}`}
								alt="Travel document"
								className="mx-auto max-w-full rounded-lg"
								style={{ maxWidth: 280 }}
							/>
							<p
								className="mt-2 text-center text-xs"
								style={{ color: "var(--wayfare-text-secondary)" }}
							>
								Valid {new Date(props.startvalidity).toLocaleDateString()} –{" "}
								{new Date(props.endvalidity).toLocaleDateString()}
							</p>
						</div>
					);
				}

				return (
					<div
						key={doc.id ?? i}
						className="rounded-xl p-4"
						style={{
							background: "var(--wayfare-surface-strong)",
							border: "1px solid var(--wayfare-line)",
						}}
					>
						<p
							className="text-xs font-semibold uppercase tracking-wide"
							style={{ color: "var(--wayfare-text-secondary)" }}
						>
							External ticket
						</p>
						<p
							className="mt-1 text-sm"
							style={{ color: "var(--wayfare-text)" }}
						>
							Valid {new Date(props.startvalidity).toLocaleDateString()} –{" "}
							{new Date(props.endvalidity).toLocaleDateString()}
						</p>
						{doc.links?.map((link) => (
							<a
								key={link.href}
								href={link.href}
								target="_blank"
								rel="noreferrer"
								className="mt-2 inline-block text-sm font-medium"
								style={{ color: "var(--wayfare-primary)" }}
							>
								{link.title ?? link.rel} →
							</a>
						))}
					</div>
				);
			})}
		</div>
	);
}
