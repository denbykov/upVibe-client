import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/home/controllers/login_controller.dart';
import 'package:client/feature/widgets/app_snack_bar_widget.dart';
import 'package:client/feature/widgets/app_scaffold.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.find<LoginController>();
  final String _title = 'Login';

  LoginPage({super.key}) {
    AppSnackBarWidget();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
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
