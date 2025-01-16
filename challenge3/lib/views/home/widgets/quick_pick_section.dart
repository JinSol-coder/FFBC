import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../../viewmodels/home_viewmodel.dart';
import '../../../viewmodels/player_viewmodel.dart';
import '../../player/player_view.dart';

class QuickPickSection extends StatelessWidget {
  const QuickPickSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '빠른 선곡',
            style: AppTypography.title,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: Consumer<HomeViewModel>(
              builder: (context, viewModel, child) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: viewModel.tracks.length,
                  itemBuilder: (context, index) {
                    final track = viewModel.tracks[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<PlayerViewModel>().setTrack(
                          track,
                          viewModel.tracks,
                        );
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => const PlayerView(),
                          ),
                        );
                      },
                      child: Container(
                        width: 140,
                        margin: const EdgeInsets.only(right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: CupertinoColors.black.withOpacity(0.2),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                track.thumbnailUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              track.title,
                              style: AppTypography.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 