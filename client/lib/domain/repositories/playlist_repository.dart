import 'package:client/domain/entities/playlist.dart';

abstract class PlaylistRepository {
  Future<Playlist> addPlaylist(String url);

  Future<List<Playlist>> getPlaylists();
}
