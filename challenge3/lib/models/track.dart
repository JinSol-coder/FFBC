class Track {
  final String title;
  final String artist;
  final String youtubeUrl;
  final String thumbnailUrl;

  Track({
    required this.title,
    required this.artist,
    required this.youtubeUrl,
    required this.thumbnailUrl,
  });

  factory Track.fromMap(Map<String, String> map) {
    final titleAndArtist = map['title']!.split(' - ');
    return Track(
      title: titleAndArtist[0].trim(),
      artist: titleAndArtist[1].trim(),
      youtubeUrl: map['url']!,
      thumbnailUrl: map['thumbnail']!,
    );
  }
} 