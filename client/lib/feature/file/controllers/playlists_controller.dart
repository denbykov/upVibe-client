import 'dart:async';

import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/entities/synchronization_report.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:client/exceptions/upvibe_timeout.dart';
import 'package:client/exceptions/upvibe_error.dart';

import 'package:client/domain/repositories/playlist_repository.dart';

import 'package:client/domain/entities/playlist.dart';

class PlaylistsController extends GetxController {
  final PlaylistRepository _repository = Get.find<PlaylistRepository>();

  final playlists = Rxn<List<Playlist>>();

  StreamSubscription<SynchronizationReport>? _synchronizationSubscription;

  @override
  void onInit() async {
    super.onInit();

    playlists.value = await getPlaylists();

    _synchronizationSubscription = SynchronizationService().stream.listen(
      (SynchronizationReport data) async {
        try {
          if (data.total > 0) {
            playlists.value = await getPlaylists();
          }
        } catch (e) {
          debugPrint('Someting went wrong: $e');
        }
      },
    );
  }

  Future<List<Playlist>> getPlaylists() async {
    try {
      return await _repository.getPlaylists();
    } on UpvibeTimeout {
      Get.snackbar('Error', 'Upvibe server does not respond');
      return [];
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return [];
    } on Exception catch (e) {
      debugPrint('Something went wrong: $e');
      Get.snackbar('Error', 'Something went wrong');
      return [];
    }
  }

  void stop() {
    _synchronizationSubscription?.cancel();
  }
}
