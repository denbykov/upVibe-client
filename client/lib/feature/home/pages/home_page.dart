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
              Obx(() => Text("${_controller.count}")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _controller.increment,
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ));
  }
}
