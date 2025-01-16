import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/player_viewmodel.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class ProgressSlider extends StatelessWidget {
  const ProgressSlider({super.key});

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerViewModel>(
      builder: (context, viewModel, child) {
        return Column(
          children: [
            CupertinoSlider(
              value: viewModel.position.inSeconds.toDouble(),
              min: 0,
              max: viewModel.duration.inSeconds.toDouble(),
              activeColor: AppColors.primary,
              onChanged: (value) {
                viewModel.seekTo(Duration(seconds: value.toInt()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(viewModel.position),
                    style: AppTypography.body.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    _formatDuration(viewModel.duration),
                    style: AppTypography.body.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
} 