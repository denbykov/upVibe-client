import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/splash_screen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  final SplashScreenController _controller = Get.find<SplashScreenController>();

  SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.initialize();

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Loading...',
            ),
          ],
        ),
      ),
    );
  }
}
