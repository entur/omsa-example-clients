interface LoadingSpinnerProps {
	label?: string;
}

export default function LoadingSpinner({
	label = "Loading…",
}: LoadingSpinnerProps) {
	return (
		<div className="flex flex-col items-center justify-center gap-3 py-12">
			<div
				className="h-8 w-8 animate-spin rounded-full border-4"
				style={{
					borderColor: "var(--wayfare-line)",
					borderTopColor: "var(--wayfare-primary)",
				}}
				aria-hidden="true"
			/>
			<p className="text-sm" style={{ color: "var(--wayfare-text-secondary)" }}>
				{label}
			</p>
		</div>
	);
}
