import 'package:client/feature/controllers/source_icon_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SourceIconWidget extends StatelessWidget {
  final SourceIconController _controller = Get.find<SourceIconController>();

  final String id;
  final Color color;
  final double? width;
  final double? height;

  SourceIconWidget({
    super.key,
    required this.id,
    required this.color,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    _controller.loadIconBySourceId(id);

    return Obx(
      () {
        if (_controller.data.value != null) {
          return SvgPicture(
            width: width,
            height: height,
            _controller.data.value!.bytesLoader,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          );
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
