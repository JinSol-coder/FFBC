import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        final track = viewModel.currentTrack;
        if (track == null) return const SizedBox.shrink();

        return Container(
          height: 60,
          color: AppColors.background,
          child: Row(
            children: [
              Image.network(
                track.thumbnailUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.title,
                      style: AppTypography.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      track.artist,
                      style: AppTypography.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              CupertinoButton(
                padding: const EdgeInsets.all(12),
                onPressed: () {
                  // TODO: Toggle play/pause
                },
                child: const Icon(
                  CupertinoIcons.play_fill,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 