import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/player_viewmodel.dart';
import '../../../core/constants/app_colors.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.shuffle,
                color: AppColors.secondary,
                size: 24,
              ),
              onPressed: () {
                // TODO: Implement shuffle
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.backward_fill,
                color: AppColors.text,
                size: 32,
              ),
              onPressed: () {
                // TODO: Previous track
              },
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(32),
              child: Icon(
                viewModel.isPlaying
                    ? CupertinoIcons.pause_fill
                    : CupertinoIcons.play_fill,
                color: CupertinoColors.white,
                size: 32,
              ),
              onPressed: () {
                if (viewModel.isPlaying) {
                  viewModel.pause();
                } else {
                  viewModel.play();
                }
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.forward_fill,
                color: AppColors.text,
                size: 32,
              ),
              onPressed: () {
                // TODO: Next track
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.repeat,
                color: AppColors.secondary,
                size: 24,
              ),
              onPressed: () {
                // TODO: Implement repeat
              },
            ),
          ],
        );
      },
    );
  }
} 