import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/core/routes.dart';

import 'package:client/domain/repositories/playlist_repository.dart';

class AddPlaylistController extends GetxController {
  final PlaylistRepository _repository = Get.find<PlaylistRepository>();

  final urlFieldController = TextEditingController();

  Future<void> addPlaylist() async {
    try {
      var url = urlFieldController.text;
      var playlist = await _repository.addPlaylist(url);

      Get.offAndToNamed(Routes.playlist,
          arguments: {'id': playlist.id.toString()});
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
    } on UpvibeError catch (ex) {
      if (ex.type == UpvibeErrorType.generic) {
        Get.snackbar('Error', ex.message);
      }
    }
  }
}
