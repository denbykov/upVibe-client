import 'package:flutter/material.dart';

class AppPageRoute extends MaterialPageRoute {
  AppPageRoute({builder}) : super(builder: builder);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}
