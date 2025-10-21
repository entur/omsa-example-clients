import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/services/bff_service.dart';
import 'package:omsa_demo_app/screens/search_screen.dart';

class AuthLoadingScreen extends StatefulWidget {
  const AuthLoadingScreen({super.key});

  @override
  State<AuthLoadingScreen> createState() => _AuthLoadingScreenState();
}

class _AuthLoadingScreenState extends State<AuthLoadingScreen> {
  String _status = 'Initializing authentication...';
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    try {
      setState(() {
        _status = 'Checking backend configuration...';
        _hasError = false;
      });

      if (!BffService.isConfigured) {
        setState(() {
          _hasError = true;
          _errorMessage =
              'Backend not configured.\n\nUpdate lib/config.dart with your BFF URL or pass --dart-define=BFF_BASE_URL=... when running the app.';
        });
        return;
      }

      setState(() {
        _status = 'Contacting the OMSA BFF...';
      });

      final success = await BffService.checkBackendHealth();

      if (success && mounted) {
        setState(() {
          _status = 'Backend ready!';
        });

        // Small delay to show success message
        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        }
      } else {
        setState(() {
          _hasError = true;
          _errorMessage =
              'Could not reach the BFF.\n\nEnsure the FastAPI service is running and the URL in lib/config.dart (or your --dart-define) matches its address.';
        });
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Backend initialization error:\n$e';
      });
    }
  }

  Future<void> _retry() async {
    setState(() {
      _hasError = false;
      _errorMessage = '';
    });
    await _initializeAuth();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final semanticColors = context.semanticColors;

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
                // Logo/Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: semanticColors.frameElevated,
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
                    _hasError ? Icons.error_outline : Icons.train,
                    size: 60,
                    color: _hasError
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 32),

                // App Title
                const Text(
                  'OMSA Travel Demo',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                Text(
                  'Open Mobility Sales API',
                  style: TextStyle(fontSize: 16, color: semanticColors.textSubdued),
                ),
                const SizedBox(height: 48),

                if (!_hasError) ...[
                  // Loading indicator
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(strokeWidth: 3),
                  ),
                  const SizedBox(height: 24),

                  // Status text
                  Text(
                    _status,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: semanticColors.textSubdued),
                  ),
                ] else ...[
                  // Error state
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onErrorContainer,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Retry button
                  ElevatedButton.icon(
                    onPressed: _retry,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry Authentication'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],

                const Spacer(),

                // Footer info
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: semanticColors.frameElevated.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: semanticColors.textSubdued,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Powered by Entur',
                            style: TextStyle(
                              fontSize: 12,
                              color: semanticColors.textSubdued,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Connecting through the OMSA BFF',
                        style: TextStyle(
                          fontSize: 11,
                          color: semanticColors.textSubduedAlt,
                        ),
                      ),
                    ],
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
