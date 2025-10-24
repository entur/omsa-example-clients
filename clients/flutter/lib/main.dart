import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/screens/auth_loading_screen.dart';
import 'package:app_links/app_links.dart';
import 'package:logger/logger.dart';

final Logger _logger = Logger();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: OmsaDemoApp(),
    ),
  );
}

class OmsaDemoApp extends StatefulWidget {
  const OmsaDemoApp({super.key});

  @override
  State<OmsaDemoApp> createState() => _OmsaDemoAppState();
}

class _OmsaDemoAppState extends State<OmsaDemoApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  bool _initialLinkHandled = false;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uri) {
        _logger.i('Deep link received while app running: $uri');
        _initialLinkHandled = true;
        _handleDeepLink(uri, isInitial: false);
      },
      onError: (err) {
        _logger.e('Deep link error: $err');
      },
    );

    // Handle the initial link when app was opened via deep link (cold start only)
    try {
      final initialUri = await _appLinks.getInitialLink();
      if (initialUri != null && !_initialLinkHandled) {
        _logger.i('App opened with initial deep link: $initialUri');
        Future.delayed(const Duration(seconds: 2), () {
          if (!_initialLinkHandled) {
            _handleDeepLink(initialUri, isInitial: true);
            _initialLinkHandled = true;
          }
        });
      }
    } catch (e) {
      _logger.e('Failed to get initial deep link: $e');
    }
  }

  void _handleDeepLink(Uri uri, {required bool isInitial}) {
    _logger.i('Handling deep link: ${uri.scheme}://${uri.host}${uri.path}');

    if (uri.scheme == 'omsa' && uri.host == 'payment') {
      final context = navigatorKey.currentContext;
      if (context != null && context.mounted) {
        final message = isInitial
            ? '✓ Payment completed! Please search for your offer again and complete the purchase.'
            : '✓ Returned from payment. You can now confirm your order.';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: const Duration(seconds: 8),
            backgroundColor: Colors.green,
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'OMSA Travel Demo',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AuthLoadingScreen(),
    );
  }
}
