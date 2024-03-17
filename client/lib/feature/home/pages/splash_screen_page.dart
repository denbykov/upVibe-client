import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

import 'package:client/feature/home/controllers/splash_screen_controller.dart';

class SplashScreenPage extends StatelessWidget {
  final SplashScreenController _controller = Get.find<SplashScreenController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();

  SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

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
