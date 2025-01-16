import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class YoutubePlayerService {
  YoutubePlayerController? _controller;
  final Function(Duration)? onPositionChanged;
  final Function(Duration)? onDurationChanged;
  final VoidCallback? onVideoEnd;
  Timer? _positionTimer;

  YoutubePlayerService({
    this.onPositionChanged,
    this.onDurationChanged,
    this.onVideoEnd,
  });

  Future<void> initialize(String videoUrl) async {
    final videoId = YoutubePlayerController.convertUrlToId(videoUrl);
    if (videoId == null) return;

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: false,
        showFullscreenButton: false,
        mute: false,
      ),
    );

    await _controller?.loadVideoById(videoId: videoId);
    _setupListeners();
  }

  void _setupListeners() {
    if (_controller == null) return;
    
    _controller!.listen((event) {
      if (event.playerState == PlayerState.ended) {
        onVideoEnd?.call();
      }
    });

    _setupPositionListener();
  }

  void _setupPositionListener() {
    if (_controller == null) return;
    
    Future.delayed(const Duration(seconds: 1), () async {
      if (_controller == null) return;
      
      final duration = await _controller!.duration;
      onDurationChanged?.call(Duration(seconds: duration.toInt()));
      
      _positionTimer?.cancel();
      _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (_controller == null) {
          timer.cancel();
          return;
        }
        
        final position = await _controller!.currentTime;
        onPositionChanged?.call(Duration(seconds: position.toInt()));
      });
    });
  }

  void play() {
    _controller?.playVideo();
  }

  void pause() {
    _controller?.pauseVideo();
  }

  void seekTo(Duration position) {
    _controller?.seekTo(seconds: position.inSeconds.toDouble());
  }

  void dispose() {
    _positionTimer?.cancel();
    _controller?.close();
  }

  YoutubePlayerController? get controller => _controller;
} 