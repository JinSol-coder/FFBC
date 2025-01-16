import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/home_viewmodel.dart';
import '../../core/constants/app_typography.dart';
import 'widgets/playlist_card.dart';
import 'widgets/mini_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('홈'),
          ),
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverSafeArea(
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '추천 플레이리스트',
                                style: AppTypography.title,
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: viewModel.playlists.length,
                                  itemBuilder: (context, index) {
                                    return PlaylistCard(
                                      playlist: viewModel.playlists[index],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              if (viewModel.currentTrack != null)
                const Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: MiniPlayer(),
                ),
            ],
          ),
        );
      },
    );
  }
} 