import 'package:flutter/foundation.dart';
import '../models/playlist.dart';
import '../models/track.dart';

class HomeViewModel extends ChangeNotifier {
  List<Playlist> _playlists = [];
  Track? _currentTrack;

  List<Playlist> get playlists => _playlists;
  Track? get currentTrack => _currentTrack;

  HomeViewModel() {
    _loadInitialData();
  }

  void _loadInitialData() {
    // 임시 데이터
    _playlists = [
      Playlist(
        id: '1',
        title: '인기 플레이리스트',
        description: '지금 가장 인기있는 음악',
        thumbnailUrl: 'https://picsum.photos/200',
        tracks: [
          Track(
            id: '1',
            title: 'Sample Track 1',
            artist: 'Artist 1',
            thumbnailUrl: 'https://picsum.photos/200',
            youtubeUrl: 'https://youtube.com/watch?v=sample1',
          ),
        ],
      ),
      Playlist(
        id: '2',
        title: '운동할 때 듣기 좋은',
        description: '활력 넘치는 음악들',
        thumbnailUrl: 'https://picsum.photos/200',
        tracks: [
          Track(
            id: '2',
            title: 'Sample Track 2',
            artist: 'Artist 2',
            thumbnailUrl: 'https://picsum.photos/200',
            youtubeUrl: 'https://youtube.com/watch?v=sample2',
          ),
        ],
      ),
    ];
    notifyListeners();
  }

  void setCurrentTrack(Track track) {
    _currentTrack = track;
    notifyListeners();
  }
} 