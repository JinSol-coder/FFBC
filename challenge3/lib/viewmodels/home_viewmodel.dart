import 'package:flutter/foundation.dart';
import '../models/track.dart';
import '../models/playlist.dart';

class HomeViewModel extends ChangeNotifier {
  List<Track> _tracks = [];
  List<Playlist> _playlists = [];
  Track? _currentTrack;

  List<Track> get tracks => _tracks;
  List<Playlist> get playlists => _playlists;
  Track? get currentTrack => _currentTrack;

  HomeViewModel() {
    _loadData();
  }

  void _loadData() {
    // music.md의 모든 트랙 데이터 추가
    final trackData = [
      {
        'title': 'After LIKE - IVE',
        'url': 'https://www.youtube.com/watch?v=F0B7HDiY-10',
        'thumbnail': 'https://i.ytimg.com/vi/F0B7HDiY-10/maxresdefault.jpg',
      },
      {
        'title': 'Hype Boy - NewJeans',
        'url': 'https://www.youtube.com/watch?v=11cta61wi0g',
        'thumbnail': 'https://i.ytimg.com/vi/11cta61wi0g/maxresdefault.jpg',
      },
      {
        'title': 'UNFORGIVEN (feat. Nile Rodgers) - LE SSERAFIM',
        'url': 'https://www.youtube.com/watch?v=UBURTj20HXI',
        'thumbnail': 'https://i.ytimg.com/vi/UBURTj20HXI/maxresdefault.jpg',
      },
      {
        'title': 'Ditto - NewJeans',
        'url': 'https://www.youtube.com/watch?v=Km71Rr9K-Bw',
        'thumbnail': 'https://i.ytimg.com/vi/Km71Rr9K-Bw/maxresdefault.jpg',
      },
      {
        'title': 'Cupid - FIFTY FIFTY',
        'url': 'https://www.youtube.com/watch?v=9GShS2Q-0qk',
        'thumbnail': 'https://i.ytimg.com/vi/9GShS2Q-0qk/maxresdefault.jpg',
      },
      {
        'title': 'OMG - NewJeans',
        'url': 'https://www.youtube.com/watch?v=sVTy_wmn5SU',
        'thumbnail': 'https://i.ytimg.com/vi/sVTy_wmn5SU/maxresdefault.jpg',
      },
      {
        'title': 'Teddy Bear - STAYC',
        'url': 'https://www.youtube.com/watch?v=P1KEbS_JQJU',
        'thumbnail': 'https://i.ytimg.com/vi/P1KEbS_JQJU/maxresdefault.jpg',
      },
      {
        'title': 'Love Dive - IVE',
        'url': 'https://www.youtube.com/watch?v=Y8JFxS1HlDo',
        'thumbnail': 'https://i.ytimg.com/vi/Y8JFxS1HlDo/maxresdefault.jpg',
      },
      {
        'title': 'ANTIFRAGILE - LE SSERAFIM',
        'url': 'https://www.youtube.com/watch?v=pyf8cbqyfPs',
        'thumbnail': 'https://i.ytimg.com/vi/pyf8cbqyfPs/maxresdefault.jpg',
      },
      {
        'title': 'Attention - NewJeans',
        'url': 'https://www.youtube.com/watch?v=js1CtxSY38I',
        'thumbnail': 'https://i.ytimg.com/vi/js1CtxSY38I/maxresdefault.jpg',
      },
    ];

    _tracks = trackData.map((data) => Track.fromMap(data)).toList();

    // 플레이리스트 생성
    _playlists = [
      Playlist(
        title: 'K-POP 인기곡',
        description: '지금 가장 인기있는 K-POP',
        thumbnailUrl: _tracks[0].thumbnailUrl,
        tracks: _tracks,
      ),
      Playlist(
        title: '운동할 때',
        description: '에너지 넘치는 음악들',
        thumbnailUrl: _tracks[1].thumbnailUrl,
        tracks: _tracks.sublist(0, 5),
      ),
      Playlist(
        title: '에너지 충전',
        description: '신나는 K-POP 모음',
        thumbnailUrl: _tracks[2].thumbnailUrl,
        tracks: _tracks.sublist(3, 8),
      ),
      Playlist(
        title: '행복한 기분',
        description: '기분 좋아지는 음악들',
        thumbnailUrl: _tracks[3].thumbnailUrl,
        tracks: _tracks.sublist(5, 10),
      ),
    ];

    notifyListeners();
  }

  void setCurrentTrack(Track track) {
    _currentTrack = track;
    notifyListeners();
  }
} 