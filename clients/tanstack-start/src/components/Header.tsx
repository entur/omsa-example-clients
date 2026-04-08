import { Link } from "@tanstack/react-router";
import ThemeToggle from "./ThemeToggle";
import WayfareWordmark from "./WayfareWordmark";

export default function Header() {
	return (
		<header
			className="sticky top-0 z-50 border-b backdrop-blur-lg"
			style={{
				borderColor: "var(--wayfare-line)",
				backgroundColor: "var(--wayfare-header-bg)",
			}}
		>
			<nav className="page-wrap flex items-center gap-4 px-4 py-3 sm:py-4">
				<Link
					to="/"
					className="flex items-center no-underline"
					style={{ color: "var(--wayfare-primary)" }}
				>
					<WayfareWordmark height={16} />
				</Link>

				<div className="ml-auto flex items-center gap-5">
					<Link
						to="/"
						className="text-sm font-medium no-underline"
						style={{ color: "var(--wayfare-text-secondary)" }}
						activeProps={{
							style: { color: "var(--wayfare-primary)", fontWeight: 700 },
						}}
					>
						Search
					</Link>
					<Link
						to="/tickets"
						className="text-sm font-medium no-underline"
						style={{ color: "var(--wayfare-text-secondary)" }}
						activeProps={{
							style: { color: "var(--wayfare-primary)", fontWeight: 700 },
						}}
					>
						Tickets
					</Link>
					<Link
						to="/settings"
						className="text-sm font-medium no-underline"
						style={{ color: "var(--wayfare-text-secondary)" }}
						activeProps={{
							style: { color: "var(--wayfare-primary)", fontWeight: 700 },
						}}
					>
						Settings
					</Link>
					<ThemeToggle />
				</div>
			</nav>
		</header>
	);
}
