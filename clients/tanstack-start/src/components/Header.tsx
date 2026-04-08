import { useRouterState } from "@tanstack/react-router";
import { Link } from "@tanstack/react-router";
import { TopNavigationItem } from "@entur/menu";
import ThemeToggle from "./ThemeToggle";
import WayfareWordmark from "./WayfareWordmark";

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

				<div className="ml-auto flex items-center gap-2">
					<TopNavigationItem as={Link} to="/" active={pathname === "/"}>
						Search
					</TopNavigationItem>
					<TopNavigationItem as={Link} to="/tickets" active={pathname.startsWith("/tickets")}>
						Tickets
					</TopNavigationItem>
					<TopNavigationItem as={Link} to="/settings" active={pathname === "/settings"}>
						Settings
					</TopNavigationItem>
					<ThemeToggle />
				</div>
			</nav>
		</header>
	);
}
