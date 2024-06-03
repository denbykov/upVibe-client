import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/feature/widgets/app_scaffold_widget.dart';

import 'package:client/feature/home/controllers/home_controller.dart';
import 'package:client/feature/home/widgets/home_drawer_widget.dart';

class HomePage extends StatelessWidget {
  final String _title = 'Home';

  final HomeController _controller = Get.find<HomeController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.initialize();

    return Obx(() {
      if (_controller.defaultFilePathIsSet.isTrue) {
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
      } else {
        return AppScaffoldWidget(
          title: _title,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Please set the defatult download directory!',
                  style: Get.textTheme.titleMedium,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _controller.changeDownloadDirectory();
                  },
                  child: const Text('Do it!'),
                ),
              ],
            ),
          ),
        );
      }
    });
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
