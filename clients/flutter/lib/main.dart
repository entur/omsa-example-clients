import 'package:flutter/material.dart';
import 'screens/auth_loading_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const OmsaDemoApp());
}

class OmsaDemoApp extends StatelessWidget {
  const OmsaDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OMSA Travel Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1565C0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF1565C0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF1565C0), width: 2),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthLoadingScreen(),
    );
  }
}
