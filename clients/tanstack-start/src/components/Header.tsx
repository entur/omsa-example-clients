import { Link, useRouterState } from "@tanstack/react-router";
import ThemeToggle from "./ThemeToggle";
import WayfareWordmark from "./WayfareWordmark";

function NavItem({
	to,
	active,
	children,
}: {
	to: string;
	active: boolean;
	children: React.ReactNode;
}) {
	return (
		<Link
			to={to}
			className="rounded-lg px-3 py-1.5 text-sm font-medium no-underline transition-colors"
			style={{
				color: active
					? "var(--wayfare-primary)"
					: "var(--wayfare-text-secondary)",
				background: active ? "var(--wayfare-accent-soft)" : "transparent",
			}}
		>
			{children}
		</Link>
	);
}

export default function Header() {
	const pathname = useRouterState({ select: (s) => s.location.pathname });

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

				<div className="ml-auto flex items-center gap-1">
					<NavItem to="/" active={pathname === "/"}>
						Search
					</NavItem>
					<NavItem to="/tickets" active={pathname.startsWith("/tickets")}>
						Tickets
					</NavItem>
					<NavItem to="/settings" active={pathname === "/settings"}>
						Settings
					</NavItem>
					<ThemeToggle />
				</div>
			</nav>
		</header>
	);
}
