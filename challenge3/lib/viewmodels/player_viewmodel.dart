import 'package:flutter/foundation.dart';
import '../models/track.dart';
import '../services/youtube_player_service.dart';

class PlayerViewModel extends ChangeNotifier {
  Track? _currentTrack;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late final YoutubePlayerService _playerService;

  PlayerViewModel() {
    _playerService = YoutubePlayerService(
      onPositionChanged: (position) {
        _position = position;
        notifyListeners();
      },
      onDurationChanged: (duration) {
        _duration = duration;
        notifyListeners();
      },
      onVideoEnd: () {
        _isPlaying = false;
        notifyListeners();
      },
    );
  }

  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  YoutubePlayerService get playerService => _playerService;

  void setTrack(Track track) {
    _currentTrack = track;
    _position = Duration.zero;
    _duration = Duration.zero;
    _playerService.initialize(track.youtubeUrl);
    _isPlaying = true;
    notifyListeners();
  }

  void play() {
    _isPlaying = true;
    _playerService.play();
    notifyListeners();
  }

  void pause() {
    _isPlaying = false;
    _playerService.pause();
    notifyListeners();
  }

  void seekTo(Duration position) {
    _position = position;
    _playerService.seekTo(position);
    notifyListeners();
  }

  @override
  void dispose() {
    _playerService.dispose();
    super.dispose();
  }
} 