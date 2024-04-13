import 'package:flutter/material.dart';
import 'package:client/feature/theme.dart';

class AppScaffoldWidget extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final List<Widget>? appBarActions;

  const AppScaffoldWidget({
    super.key,
    required this.title,
    required this.body,
    this.appBarActions,
    this.drawer,
    this.floatingActionButton,
  });

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
        actions: appBarActions,
      ),
      body: body,
      drawer: drawer,
      floatingActionButton: floatingActionButton,
      drawerScrimColor: drawerScrimColor,
    );
  }
}
