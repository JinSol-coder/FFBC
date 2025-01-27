import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaWidget extends StatelessWidget {
  final String url;
  final VideoPlayerController? controller;

  const MediaWidget({
    super.key,
    required this.url,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (url.contains('.mp4')) {
      return _buildVideoPlayer();
    } else {
      return _buildImage();
    }
  }

  Widget _buildVideoPlayer() {
    if (controller == null) return const SizedBox();
    
    return AspectRatio(
      aspectRatio: controller!.value.aspectRatio,
      child: Stack(
        alignment: Alignment.center,
        children: [
          VideoPlayer(controller!),
          IconButton(
            icon: Icon(
              controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              if (controller!.value.isPlaying) {
                controller!.pause();
              } else {
                controller!.play();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }
} 