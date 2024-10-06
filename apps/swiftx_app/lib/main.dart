import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_locator.dart';
import 'package:swiftx_app/core/app_router.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = locator<AppRouter>();
    return MaterialApp.router(
      theme: ThemeData(
        primaryColor: const Color(0xff304FFF),
        scaffoldBackgroundColor: const Color(0xffFAFAFA),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff304FFF)),
        useMaterial3: true,
      ),
      routerConfig: router.config(),
    );
  }
}
