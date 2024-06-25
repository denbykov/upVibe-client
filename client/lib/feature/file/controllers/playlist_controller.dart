import 'dart:async';

import 'package:client/core/services/synchronization_service.dart';
import 'package:client/domain/entities/playlist.dart';
import 'package:client/domain/entities/synchronization_report.dart';
import 'package:client/domain/repositories/playlist_repository.dart';
import 'package:client/exceptions/upvibe_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PlaylistController extends GetxController {
  late String _playlistId;

  final playlist = Rxn<Playlist>();

  final PlaylistRepository _playlistRepository = Get.find<PlaylistRepository>();
  Timer? _playlistUpdateTimer;

  StreamSubscription<SynchronizationReport>? _synchronizationSubscription;

  @override
  void onInit() async {
    super.onInit();
    _playlistId = Get.arguments['id'];

    _synchronizationSubscription = SynchronizationService().stream.listen(
      (SynchronizationReport data) async {
        try {
          if (data.synchronizedFiles.contains(_playlistId)) {
            await loadPlaylist();
          }
        } catch (e) {
          debugPrint('Someting went wrong: $e');
        }
      },
    );

    await loadPlaylist();

    _playlistUpdateTimer?.cancel();
    _playlistUpdateTimer =
        Timer.periodic(const Duration(seconds: 5), (timer) async {
      try {
        await loadPlaylist();
      } catch (e) {
        debugPrint('Someting went wrong: $e');
      }
    });
  }

  void stop() {
    _synchronizationSubscription?.cancel();
    _playlistUpdateTimer?.cancel();
  }

  Future<void> loadPlaylist() async {
    try {
      playlist.value = await _playlistRepository.getPlaylist(
        _playlistId,
      );
    } on UpvibeError catch (e) {
      debugPrint('${e.toString()}: ${e.errMsg()}');
      Get.snackbar('Error', 'Something went wrong');
      return;
    } on Exception catch (e) {
      debugPrint('Something went wrong: $e');
      Get.snackbar('Error', 'Something went wrong');
      return;
    }
  }

  Future<void> onSourceTapped() async {
    if (playlist.value!.sourceUrl == null) {
      Get.snackbar('Error', 'No source URL available');
      return;
    }

    await Clipboard.setData(ClipboardData(text: playlist.value!.sourceUrl!));
    Get.snackbar('Source URL copied', playlist.value!.sourceUrl!);
  }
}
