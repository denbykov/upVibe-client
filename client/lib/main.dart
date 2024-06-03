import 'package:flutter/material.dart';
import 'package:client/core/app.dart';
import 'package:client/core/bindings/home_binding.dart';

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  HomeBinding().dependencies();

  final prefs = await SharedPreferences.getInstance();
  final inBrightMode = prefs.getBool('inBrightMode') ?? true;

  runApp(App(inBrightMode: inBrightMode));
}
