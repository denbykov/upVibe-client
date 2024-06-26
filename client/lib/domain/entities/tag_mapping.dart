class TagMapping {
  final String title;
  final String artist;
  final String album;
  final String year;
  final String trackNumber;
  final String picture;

  const TagMapping({
    required this.title,
    required this.artist,
    required this.album,
    required this.year,
    required this.trackNumber,
    required this.picture,
  });

  TagMapping copyWith({
    String? title,
    String? artist,
    String? album,
    String? year,
    String? trackNumber,
    String? picture,
  }) {
    return TagMapping(
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      year: year ?? this.year,
      trackNumber: trackNumber ?? this.trackNumber,
      picture: picture ?? this.picture,
    );
  }
}
