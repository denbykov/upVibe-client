import 'package:client/domain/entities/playlist.dart';

import 'package:client/domain/repositories/playlist_repository.dart';
import 'package:client/data/remote/upvibe_remote_datasource.dart';

import 'package:get/get.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  final UpvibeRemoteDatasource _upvibeRemoteDatasource =
      Get.find<UpvibeRemoteDatasource>();

  @override
  Future<Playlist> addPlaylist(String url) async {
    var data = await _upvibeRemoteDatasource.addPlaylist(url);
    return data.toEntity();
  }

  @override
  Future<List<Playlist>> getPlaylists() async {
    var data = await _upvibeRemoteDatasource.getPlaylists();
    return data.map((dto) => dto.toEntity()).toList();
  }
}
