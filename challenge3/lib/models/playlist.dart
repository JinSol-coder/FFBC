import 'track.dart';

class Playlist {
  final String title;
  final String description;
  final String thumbnailUrl;
  final List<Track> tracks;

  Playlist({
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.tracks,
  });
} 