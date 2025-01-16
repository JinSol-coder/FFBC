import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/player_viewmodel.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../player/player_view.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        final track = viewModel.currentTrack;
        if (track == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => const PlayerView(),
              ),
            );
          },
          child: Container(
            color: CupertinoColors.black,
            child: Container(
              padding: const EdgeInsets.all(8),
              height: 76,
              decoration: BoxDecoration(
                color: CupertinoColors.black.withOpacity(0.9),
                border: Border(
                  top: BorderSide(
                    color: CupertinoColors.systemGrey.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      track.thumbnailUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          track.title,
                          style: AppTypography.subtitle.copyWith(
                            color: AppColors.text,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          track.artist,
                          style: AppTypography.body.copyWith(
                            color: AppColors.subtext,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  CupertinoButton(
                    padding: const EdgeInsets.all(12),
                    onPressed: () {
                      if (viewModel.isPlaying) {
                        viewModel.pause();
                      } else {
                        viewModel.play();
                      }
                    },
                    child: Icon(
                      viewModel.isPlaying 
                          ? CupertinoIcons.pause_fill 
                          : CupertinoIcons.play_fill,
                      color: AppColors.primary,
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
} 