import 'package:flutter/material.dart';
import 'package:client/feature/theme.dart';
import 'package:flutter/scheduler.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;

  const AppScaffold(
      {super.key,
      required this.title,
      required this.body,
      this.drawer,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    var surfaceTP = toTonalPalette(Theme.of(context).colorScheme.surface.value);
    var isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Color drawerScrimColor;

    if (isDarkMode) {
      drawerScrimColor = Color(surfaceTP.get(8)).withOpacity(0.54);
    } else {
      drawerScrimColor = Color(surfaceTP.get(99)).withOpacity(0.54);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // backgroundColor: appBarBackgroundColor,
      ),
      body: body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      drawerScrimColor: drawerScrimColor,
    );
  }
}
