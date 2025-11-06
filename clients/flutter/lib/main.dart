import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:omsa_demo_app/screens/error_screen.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/wayfare_app.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:omsa_demo_app/services/bff_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    ChangeNotifierProvider(
      create: (_) => OfferSelectionProvider(),
      child: const OmsaDemoApp(),
    ),
  );
}

class OmsaDemoApp extends StatefulWidget {
  const OmsaDemoApp({super.key});

  @override
  State<OmsaDemoApp> createState() => _OmsaDemoAppState();
}

class _OmsaDemoAppState extends State<OmsaDemoApp> {
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Check if BFF is configured
      if (!BffService.isConfigured) {
        setState(() {
          _hasError = true;
          _errorMessage =
              'Backend not configured.\n\nUpdate lib/config.dart with your BFF URL or pass --dart-define=BFF_BASE_URL=... when running the app.';
          _isInitialized = true;
        });
        FlutterNativeSplash.remove();
        return;
      }

      // Check backend health
      final success = await BffService.checkBackendHealth();

      if (success && mounted) {
        setState(() {
          _isInitialized = true;
        });
      } else {
        setState(() {
          _hasError = true;
          _errorMessage =
              'Could not reach the BFF.\n\nEnsure the FastAPI service is running and the URL in lib/config.dart (or your --dart-define) matches its address.';
          _isInitialized = true;
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Backend initialization error:\n$e';
        _isInitialized = true;
      });
    } finally {
      FlutterNativeSplash.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMSA Travel Demo',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: !_isInitialized
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _hasError
          ? ErrorScreen(
              errorMessage: _errorMessage,
              onRetry: () {
                setState(() {
                  _isInitialized = false;
                  _hasError = false;
                  _errorMessage = '';
                });
                _initializeApp();
              },
            )
          : const WayfareApp(),
    );
  }
}
