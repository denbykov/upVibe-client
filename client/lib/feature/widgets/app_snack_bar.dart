import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';

class AppSnackBar {
  final SnackBarController _controller = Get.find<SnackBarController>();

  AppSnackBar() {
    ever(_controller.display, (display) {
      if (display) {
        Get.showSnackbar(
          GetSnackBar(
            title: _controller.title,
            message: _controller.message,
            icon: const Icon(Icons.error),
            duration: Duration(seconds: _controller.duration),
          ),
        );
      }
    });
  }
}
