import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../models/playlist.dart';
import '../../../viewmodels/player_viewmodel.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';
import '../../player/player_view.dart';
import '../../playlist/playlist_detail_view.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;

  const PlaylistCard({
    super.key,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => PlaylistDetailView(playlist: playlist),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 썸네일 이미지
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                playlist.thumbnailUrl,
                fit: BoxFit.cover,
              ),
            ),
            // 텍스트 정보 (하단에 그라데이션과 함께 표시)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      CupertinoColors.black.withOpacity(0),
                      CupertinoColors.black.withOpacity(0.7),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(12),
                child: Text(
                  playlist.title,
                  style: AppTypography.subtitle.copyWith(
                    color: CupertinoColors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 