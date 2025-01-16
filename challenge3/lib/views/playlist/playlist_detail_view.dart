import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../models/playlist.dart';
import '../../models/track.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../player/player_view.dart';

class PlaylistDetailView extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetailView({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back, color: CupertinoColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 플레이리스트 헤더
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // 플레이리스트 썸네일
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(playlist.thumbnailUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 플레이리스트 정보
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist.title,
                            style: AppTypography.title,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${playlist.tracks.length}곡',
                            style: AppTypography.body.copyWith(
                              color: AppColors.subtext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 전체 재생 버튼
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoButton.filled(
                  onPressed: () {
                    if (playlist.tracks.isNotEmpty) {
                      context.read<PlayerViewModel>().setTrack(
                        playlist.tracks.first,
                        playlist.tracks,
                      );
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => const PlayerView(),
                        ),
                      );
                    }
                  },
                  child: const Text('전체 재생'),
                ),
              ),
            ),
            // 트랙 리스트
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final track = playlist.tracks[index];
                  return _TrackListTile(
                    track: track,
                    playlist: playlist.tracks,
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

class _TrackListTile extends StatelessWidget {
  final Track track;
  final List<Track> playlist;

  const _TrackListTile({
    required this.track,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        context.read<PlayerViewModel>().setTrack(track, playlist);
        Navigator.of(context).push(
          CupertinoPageRoute(
            fullscreenDialog: true,
            builder: (context) => const PlayerView(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            // 트랙 썸네일
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(track.thumbnailUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 트랙 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: AppTypography.subtitle.copyWith(
                      color: CupertinoColors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
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
            // 더보기 버튼
            CupertinoButton(
              padding: const EdgeInsets.all(12),
              onPressed: () {
                // TODO: 트랙 메뉴 표시
              },
              child: const Icon(
                CupertinoIcons.ellipsis_vertical,
                color: CupertinoColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 