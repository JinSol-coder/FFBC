import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import 'widgets/playlist_card.dart';
import 'widgets/mini_player.dart';
import 'widgets/mood_button.dart';
import 'widgets/quick_pick_section.dart';
import 'widgets/shorts_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Widget _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(CupertinoIcons.bell, color: AppColors.text),
        const SizedBox(width: 8),
        Icon(CupertinoIcons.search, color: AppColors.text),
        const SizedBox(width: 8),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.text.withOpacity(0.1),
              width: 1,
            ),
            image: DecorationImage(
              image: NetworkImage('https://example.com/profile.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Consumer<PlayerViewModel>(
          builder: (context, playerViewModel, child) {
            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    CupertinoSliverNavigationBar(
                      backgroundColor: AppColors.background,
                      border: null,
                      largeTitle: Text(
                        'JinDol Music',
                        style: TextStyle(color: AppColors.text),
                      ),
                      trailing: _buildTrailing(),
                    ),

                    // 무드 버튼 리스트
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            MoodButton(
                              title: '운동할 때',
                              icon: CupertinoIcons.flame,
                            ),
                            MoodButton(
                              title: '에너지 충전',
                              icon: CupertinoIcons.bolt,
                            ),
                            MoodButton(
                              title: '팟캐스트',
                              icon: CupertinoIcons.mic,
                            ),
                            MoodButton(
                              title: '행복한 기분',
                              icon: CupertinoIcons.heart,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 빠른 선곡 섹션
                    const SliverToBoxAdapter(
                      child: QuickPickSection(),
                    ),

                    // 플레이리스트 섹션 제목
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
                        child: Text(
                          '플레이리스트',
                          style: AppTypography.title,
                        ),
                      ),
                    ),

                    // 인기 플레이리스트 그리드
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: Consumer<HomeViewModel>(
                        builder: (context, viewModel, child) {
                          return SliverGrid(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.0,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return PlaylistCard(
                                  playlist: viewModel.playlists[index],
                                );
                              },
                              childCount: viewModel.playlists.length,
                            ),
                          );
                        },
                      ),
                    ),

                    // 하단 여백
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 100),
                    ),
                  ],
                ),

                // 미니 플레이어
                if (playerViewModel.currentTrack != null)
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: MiniPlayer(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
} 