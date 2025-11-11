import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:omsa_demo_app/models/purchase_models.dart';
import 'package:omsa_demo_app/models/travel_models.dart';
import 'package:omsa_demo_app/screens/error_screen.dart';
import 'package:omsa_demo_app/screens/offers_screen.dart';
import 'package:omsa_demo_app/screens/payment_return_screen.dart';
import 'package:omsa_demo_app/screens/purchase_confirmation_screen.dart';
import 'package:omsa_demo_app/screens/purchase_flow_screen.dart';
import 'package:omsa_demo_app/screens/ticket_screen.dart';
import 'package:omsa_demo_app/wayfare_app.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// Stream controller to handle deep links
final _deepLinkController = StreamController<Uri>.broadcast();

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
        final offers = state.extra as OfferCollection?;
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
      path: '/purchase',
      builder: (context, state) {
        final offer = state.extra as Offer?;
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
      path: '/purchase-confirmation',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        if (extras == null) {
          return ErrorScreen(
            errorMessage: 'Missing confirmation data',
            onRetry: () => context.go('/'),
          );
        }
        final documents = extras['documents'] as List<TravelDocument>?;
        final primaryTicket = extras['primaryTicket'] as TravelDocument?;
        final packageId = extras['packageId'] as String?;

        if (documents == null || documents.isEmpty || packageId == null) {
          return ErrorScreen(
            errorMessage: 'Invalid confirmation data',
            onRetry: () => context.go('/'),
          );
        }

        return PurchaseConfirmationScreen(
          documents: documents,
          primaryTicket: primaryTicket,
          packageId: packageId,
        );
      },
    ),
    GoRoute(
      path: '/ticket',
      builder: (context, state) {
        final extras = state.extra as Map<String, dynamic>?;
        if (extras == null) {
          return ErrorScreen(
            errorMessage: 'Missing ticket data',
            onRetry: () => context.go('/'),
          );
        }
        final documents = extras['documents'] as List<TravelDocument>?;
        final primaryTicket = extras['primaryTicket'] as TravelDocument?;

        if (documents == null || documents.isEmpty) {
          return ErrorScreen(
            errorMessage: 'No documents provided',
            onRetry: () => context.go('/'),
          );
        }

        return TicketScreen(documents: documents, primaryTicket: primaryTicket);
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
