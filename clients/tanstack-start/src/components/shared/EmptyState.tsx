interface EmptyStateProps {
	icon?: React.ReactNode;
	title: string;
	description?: string;
	action?: React.ReactNode;
}

export default function EmptyState({
	icon,
	title,
	description,
	action,
}: EmptyStateProps) {
	return (
		<div className="flex flex-col items-center py-16 text-center">
			{icon && (
				<div
					className="mb-4 flex h-16 w-16 items-center justify-center rounded-full"
					style={{ background: "var(--wayfare-accent-soft)" }}
				>
					{icon}
				</div>
			)}
			<p
				className="text-sm font-semibold"
				style={{ color: "var(--wayfare-text)" }}
			>
				{title}
			</p>
			{description && (
				<p
					className="mt-1 max-w-xs text-xs"
					style={{ color: "var(--wayfare-text-secondary)" }}
				>
					{description}
				</p>
			)}
			{action && <div className="mt-4">{action}</div>}
		</div>
	);
}
