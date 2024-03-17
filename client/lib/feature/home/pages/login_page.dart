import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final String _title = 'Login';

  final LoginController _controller = Get.find<LoginController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

    return AppScaffoldWidget(
      title: _title,
      body: buildContent(),
    );
  }

  Center buildContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await _controller.login();
            },
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(color: Colors.white)),
            child: const Text('Login'),
          )
        ],
      ),
    );
  }
}
