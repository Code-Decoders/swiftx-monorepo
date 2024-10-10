import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSupabase();
  setupLocator();
  runApp(const MyApp());
}

Future<void> initSupabase() async {
  try {
    await Supabase.initialize(
        url: 'https://ewxiidixnidmpnkgivwu.supabase.co',
        anonKey:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV3eGlpZGl4bmlkbXBua2dpdnd1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0NzgwMDksImV4cCI6MjA0NDA1NDAwOX0.6vuqfeAT2yKdgGZo5n8lIY5d8dfdnwZEQYSIR3MldpY");
    debugPrint('Supabase initialized');
  } catch (e) {
    debugPrint('Error initializing Supabase: $e');
  }
}

final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbarKey,
      theme: ThemeData(
          primaryColor: const Color(0xff304FFF),
          scaffoldBackgroundColor: const Color(0xffFAFAFA),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff304FFF)),
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headlineMedium:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          canvasColor: Colors.white),
      routerConfig: router.config(),
    );
  }
}
