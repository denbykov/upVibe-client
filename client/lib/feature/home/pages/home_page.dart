import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/snackBars.dart';

import 'package:client/feature/controllers/snack_bar_controller.dart';
import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/home_controller.dart';
import 'package:client/feature/home/widgets/home_drawer_widget.dart';

class HomePage extends StatelessWidget {
  final String _title = 'Home';

  final HomeController _controller = Get.find<HomeController>();
  final SnackBarController _snackBarController = Get.find<SnackBarController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _snackBarController.registerOnErrorCallback(showErrorSnackBar);

    return AppScaffoldWidget(
      title: _title,
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.navigateToAdd();
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      drawer: HomeDrawerWidget(),
    );
  }

  Center buildBody() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Not yet implemented...',
          ),
        ],
      ),
    );
  }
}
