import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:omsa_demo_app/screens/error_screen.dart';
import 'package:omsa_demo_app/screens/offers_screen.dart';
import 'package:omsa_demo_app/screens/payment_return_screen.dart';
import 'package:omsa_demo_app/screens/purchase_confirmation_screen.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';
import 'package:omsa_demo_app/screens/ticket_screen.dart';
import 'package:omsa_demo_app/wayfare_app.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final uri = state.uri;
    debugPrint(
      'GoRouter redirect: location=${state.matchedLocation}, fullPath=${state.fullPath}, uri=$uri',
    );

    // Handle custom scheme deep links (wayfareapp://)
    if (uri.scheme == 'wayfareapp') {
      // Extract the path from the custom scheme URL
      // wayfareapp://payment-return -> /payment-return
      final path = '/${uri.host}${uri.path}';
      debugPrint('GoRouter: Redirecting custom scheme to path: $path');
      return path;
    }

    return null; // No redirect
  },
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WayfareApp()),
    GoRoute(
      path: '/offers',
      builder: (context, state) {
        final offers = context.read<OfferSelectionProvider>().offerCollection;
        if (offers == null) {
          return ErrorScreen(
            errorMessage: 'Missing offer data',
            onRetry: () => context.go('/'),
          );
        }
        return OffersScreen(offers: offers);
      },
    ),
    GoRoute(
      path: '/purchase/:offerId',
      builder: (context, state) {
        final rawOfferId = state.pathParameters['offerId'];
        if (rawOfferId == null || rawOfferId.isEmpty) {
          return ErrorScreen(
            errorMessage: 'Missing offer id',
            onRetry: () => context.go('/'),
          );
        }
        final offerId = Uri.decodeComponent(rawOfferId);
        final offer = context.read<OfferSelectionProvider>().findOfferById(
          offerId,
        );
        if (offer == null) {
          return ErrorScreen(
            errorMessage: 'Missing offer data',
            onRetry: () => context.go('/'),
          );
        }
        return PurchaseFlowScreen(offer: offer);
      },
    ),
    GoRoute(
      path: '/purchase-confirmation/:packageId',
      builder: (context, state) {
        final rawPackageId = state.pathParameters['packageId'];
        if (rawPackageId == null || rawPackageId.isEmpty) {
          return ErrorScreen(
            errorMessage: 'Missing package id',
            onRetry: () => context.go('/'),
          );
        }
        final packageId = Uri.decodeComponent(rawPackageId);
        return PurchaseConfirmationScreen(packageId: packageId);
      },
    ),
    GoRoute(
      path: '/ticket/:packageId',
      builder: (context, state) {
        final rawPackageId = state.pathParameters['packageId'];
        if (rawPackageId == null || rawPackageId.isEmpty) {
          return ErrorScreen(
            errorMessage: 'Missing package id',
            onRetry: () => context.go('/'),
          );
        }
        final packageId = Uri.decodeComponent(rawPackageId);
        return TicketScreen(packageId: packageId);
      },
    ),
    // Deep link route for payment return
    GoRoute(
      path: '/payment-return',
      builder: (context, state) {
        // Show a loading screen that checks for pending payment and completes it
        return const PaymentReturnScreen();
      },
    ),
  ],
  errorBuilder: (context, state) => ErrorScreen(
    errorMessage: 'Page not found: ${state.matchedLocation}',
    onRetry: () => context.go('/'),
  ),
);
