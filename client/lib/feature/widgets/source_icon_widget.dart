import 'package:client/feature/controllers/assets_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SourceIconWidget extends StatelessWidget {
  final AssetsController _assetsController = Get.find<AssetsController>();

  final int id;
  final Color color;

  SourceIconWidget({
    super.key,
    required this.id,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SvgPicture>(
      future: _assetsController.getIconBySourceId(id),
      builder: (BuildContext context, AsyncSnapshot<SvgPicture> snapshot) {
        if (snapshot.hasData) {
          return SvgPicture(snapshot.data!.bytesLoader,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
        }
        return SizedBox(
          height: 24.0,
          width: 24.0,
          child: SpinKitPulse(
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        );
      },
    );
  }
}
