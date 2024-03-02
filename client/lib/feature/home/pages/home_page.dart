import 'package:client/feature/home/controllers/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../widgets/home_drawer_widget.dart';

// class EventsPage extends StatefulWidget {
//   const EventsPage({super.key});

//   final String title = 'Events';

//   @override
//   State<EventsPage> createState() => _EventPageState();
// }

// class _EventPageState extends State<EventsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Not yet implemented...',
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         tooltip: 'Add',
//         child: const Icon(Icons.add),
//       ),
//       drawer: const HomeDrawerWidget(),
//     );
//   }
// }

class HomePage extends GetView {
  final HomeController _controller = Get.find<HomeController>();
  final String _title = "Events";

  @override
  Widget build(BuildContext context) {
    ever(_controller.showSnackBar, (showSnackBar) {
      if (showSnackBar) {
        Get.showSnackbar(
          GetSnackBar(
            title: 'Titule',
            message: 'User Registered Successfully',
            icon: const Icon(Icons.refresh),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Text(
            //   'Not yet implemented...',
            // ),
            Obx(() => Text("${_controller.showSnackBar}")),
            // Text(
            //   'Not yet implemented...',
            // ),
            // Obx(() => Text("${_controller.count}")),
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
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _controller.increment,
      //   tooltip: 'Add',
      //   child: const Icon(Icons.add),
      // )
    );
  }
}
