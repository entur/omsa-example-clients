import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/screens/search_screen.dart';
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
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: !_isInitialized
          ? const Scaffold(body: Center(child: CircularProgressIndicator()))
          : _hasError
          ? _ErrorScreen(
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
          : const SearchScreen(),
    );
  }
}

class _ErrorScreen extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const _ErrorScreen({required this.errorMessage, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withValues(alpha: 0.1),
              theme.colorScheme.primary.withValues(alpha: 0.05),
            ],
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 40, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: SemanticColorTokens.fillBackgroundStandardLight,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.error_outline,
                    size: 60,
                    color: theme.colorScheme.error,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'OMSA Travel Demo',
                  style: AppTypography.headingExtraLarge3.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.error.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: theme.colorScheme.onErrorContainer,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Configuration Error',
                            style: AppTypography.textLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        errorMessage,
                        style: AppTypography.textMedium.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Retry Connection'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
