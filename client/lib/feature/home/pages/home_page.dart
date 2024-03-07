import 'package:flutter/material.dart';
// import 'package:get/get.dart';

import 'package:client/feature/home/widgets/home_drawer_widget.dart';

class HomePage extends StatelessWidget {
  final String _title = 'Home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Not yet implemented...',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      drawer: HomeDrawerWidget(),
    );
  }
}
