import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final track = viewModel.currentTrack;
        if (track == null) return const SizedBox.shrink();

        return Material(
          color: AppColors.background,
          child: CupertinoPageScaffold(
            backgroundColor: AppColors.background,
            child: SafeArea(
              child: Column(
                children: [
                  // 상단 헤더
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            CupertinoIcons.chevron_down,
                            color: AppColors.text,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Spacer(),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            CupertinoIcons.ellipsis,
                            color: AppColors.text,
                          ),
                          onPressed: () {
                            // TODO: 더보기 메뉴
                          },
                        ),
                      ],
                    ),
                  ),
                  // YouTube 플레이어
                  Container(
                    color: CupertinoColors.black,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: YoutubePlayer(
                        controller: viewModel.controller,
                        aspectRatio: 16 / 9,
                      ),
                    ),
                  ),
                  // 컨트롤 버튼들
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 36),
                          onPressed: viewModel.playPrevious,
                        ),
                        IconButton(
                          icon: Icon(
                            viewModel.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                            color: Colors.white,
                            size: 48,
                          ),
                          onPressed: () {
                            if (viewModel.isPlaying) {
                              viewModel.pause();
                            } else {
                              viewModel.play();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next, color: Colors.white, size: 36),
                          onPressed: viewModel.playNext,
                        ),
                      ],
                    ),
                  ),
                  // 진행 상태 바
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            activeTrackColor: Colors.white,
                            inactiveTrackColor: Colors.white.withOpacity(0.3),
                            thumbColor: Colors.white,
                            trackHeight: 2.0,
                          ),
                          child: Slider(
                            value: viewModel.position.inSeconds.toDouble(),
                            max: viewModel.duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              viewModel.seekTo(Duration(seconds: value.toInt()));
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(viewModel.position),
                                style: const TextStyle(color: Colors.white70),
                              ),
                              Text(
                                _formatDuration(viewModel.duration),
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.title,
                            style: AppTypography.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            track.artist,
                            style: AppTypography.subtitle.copyWith(
                              color: AppColors.subtext,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
} 