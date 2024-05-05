import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final String _title = 'Login';

  final LoginController _controller = Get.find<LoginController>();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWidget(
      title: _title,
      body: buildContent(),
    );
  }

  Center buildContent() {
    _controller.login();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () {
              if (_controller.loginFailed.isFalse) {
                return const CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: () async {
                    await _controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Text('Retry login'),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
