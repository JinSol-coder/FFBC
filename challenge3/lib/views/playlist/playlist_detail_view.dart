import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/playlist.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import 'widgets/track_list_tile.dart';

class PlaylistDetailView extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetailView({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.background,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.background,
        middle: Text('플레이리스트'),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 헤더 섹션
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 플레이리스트 표지
                    Container(
                      width: 200,
                      height: 200,
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
                          playlist.thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 플레이리스트 정보
                    Text(
                      playlist.title,
                      style: AppTypography.title,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      playlist.description,
                      style: AppTypography.body.copyWith(
                        color: AppColors.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    // 전체 재생 버튼
                    CupertinoButton.filled(
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(CupertinoIcons.play_fill),
                          SizedBox(width: 8),
                          Text('전체 재생'),
                        ],
                      ),
                      onPressed: () {
                        if (playlist.tracks.isNotEmpty) {
                          final playerViewModel = context.read<PlayerViewModel>();
                          playerViewModel.setTrack(playlist.tracks.first);
                          // TODO: 나머지 트랙들을 재생 큐에 추가
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // 트랙 리스트
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final track = playlist.tracks[index];
                  return TrackListTile(
                    track: track,
                    onTap: () {
                      final playerViewModel = context.read<PlayerViewModel>();
                      playerViewModel.setTrack(track);
                    },
                  );
                },
                childCount: playlist.tracks.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 