import 'package:get/get.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/entities/playlist.dart';

class PlaylistListItemController extends GetxController {
  void onTapped(Playlist playlist) {
    Get.toNamed(Routes.playlist, arguments: {'id': playlist.id.toString()});
  }
}
