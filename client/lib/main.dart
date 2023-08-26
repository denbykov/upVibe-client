import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screens/splash_screen.dart';

import 'models/server_connection_model.dart';

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = DevHttpOverrides();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ServerConnectionModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFB5BFE2),
            brightness: Brightness.dark,
            primary: const Color(0xFFBA0F30),
            primaryContainer: const Color(0xFFBA0F30)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA0F30),
              foregroundColor: const Color(0xFFD9E0EE)),
        ),
        hintColor: const Color(0xFFACB0BE),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
