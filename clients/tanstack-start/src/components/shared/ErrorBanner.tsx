interface ErrorBannerProps {
	message: string;
	onDismiss?: () => void;
}

export default function ErrorBanner({ message, onDismiss }: ErrorBannerProps) {
	return (
		<div
			className="flex items-start justify-between gap-3 rounded-xl px-4 py-3"
			role="alert"
			style={{
				background: "rgba(233,0,55,0.08)",
				border: "1px solid rgba(233,0,55,0.2)",
			}}
		>
			<p
				className="text-sm"
				style={{ color: "var(--wayfare-primary)", margin: 0 }}
			>
				{message}
			</p>
			{onDismiss && (
				<button
					type="button"
					onClick={onDismiss}
					className="shrink-0 text-lg leading-none"
					style={{
						background: "none",
						border: "none",
						color: "var(--wayfare-primary)",
						cursor: "pointer",
					}}
					aria-label="Dismiss"
				>
					×
				</button>
			)}
		</div>
	);
}
