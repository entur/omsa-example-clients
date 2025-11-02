import 'package:flutter/material.dart';
import 'package:omsa_design_system/omsa_design_system.dart';
import 'package:omsa_demo_app/screens/auth_loading_screen.dart';
import 'package:omsa_demo_app/providers/offer_selection_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (_) => OfferSelectionProvider(),
      child: const OmsaDemoApp(),
    ),
  );
}

class OmsaDemoApp extends StatelessWidget {
  const OmsaDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMSA Travel Demo',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AuthLoadingScreen(),
    );
  }
}
