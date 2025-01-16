import 'package:flutter/foundation.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../models/track.dart';
import 'dart:async';

class PlayerViewModel extends ChangeNotifier {
  Track? _currentTrack;
  List<Track> _tracks = [];
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  late final YoutubePlayerController _controller;

  PlayerViewModel() {
    _initializePlayer();
  }

  void _initializePlayer() {
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: false,
        enableJavaScript: true,
        mute: false,
        strictRelatedVideos: true,
        enableCaption: false,
        interfaceLanguage: 'ko',
      ),
    );
  }

  Track? get currentTrack => _currentTrack;
  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  YoutubePlayerController get controller => _controller;

  Future<void> setTrack(Track track, [List<Track>? playlist]) async {
    try {
      _currentTrack = track;
      if (playlist != null) {
        _tracks = playlist;
      }
      _position = Duration.zero;
      _duration = Duration.zero;
      _isPlaying = true;

      final videoId = _extractVideoId(track.youtubeUrl);
      if (videoId != null) {
        await _controller.loadVideoById(videoId: videoId);
        await _controller.playVideo();
        _setupPositionListener();
      }
      notifyListeners();
    } catch (e) {
      print('Error setting track: $e');
    }
  }

  String? _extractVideoId(String url) {
    return YoutubePlayerController.convertUrlToId(url);
  }

  void _setupPositionListener() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_controller.value.playerState == PlayerState.playing) {
        final position = await _controller.currentTime;
        _position = Duration(seconds: position.toInt());
        final duration = await _controller.duration;
        _duration = Duration(seconds: duration.toInt());
        notifyListeners();
      }
    });
  }

  void play() {
    _isPlaying = true;
    _controller.playVideo();
    notifyListeners();
  }

  void pause() {
    _isPlaying = false;
    _controller.pauseVideo();
    notifyListeners();
  }

  void seekTo(Duration position) {
    _controller.seekTo(seconds: position.inSeconds.toDouble());
    _position = position;
    notifyListeners();
  }

  void playNext() {
    final currentIndex = _tracks.indexOf(_currentTrack!);
    if (currentIndex < _tracks.length - 1) {
      setTrack(_tracks[currentIndex + 1]);
    }
  }

  void playPrevious() {
    final currentIndex = _tracks.indexOf(_currentTrack!);
    if (currentIndex > 0) {
      setTrack(_tracks[currentIndex - 1]);
    }
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
} 