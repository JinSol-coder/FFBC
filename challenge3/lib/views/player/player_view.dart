import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import 'widgets/player_controls.dart';
import 'widgets/progress_slider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final track = viewModel.currentTrack;
        if (track == null) return const SizedBox.shrink();

        return CupertinoPageScaffold(
          backgroundColor: AppColors.background,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppColors.background,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.down_arrow),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // YouTube 플레이어 (숨김)
                if (viewModel.playerService.controller != null)
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SizedBox(
                      width: 1,
                      height: 1,
                      child: YoutubePlayerScaffold(
                        controller: viewModel.playerService.controller!,
                        aspectRatio: 16 / 9,
                        builder: (context, player) {
                          return player;
                        },
                      ),
                    ),
                  ),
                Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 앨범 아트
                          Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: CupertinoColors.black.withOpacity(0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                track.thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          // 트랙 정보
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                Text(
                                  track.title,
                                  style: AppTypography.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  track.artist,
                                  style: AppTypography.subtitle.copyWith(
                                    color: AppColors.secondary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // 재생 컨트롤
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          const ProgressSlider(),
                          const SizedBox(height: 16),
                          const PlayerControls(),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 