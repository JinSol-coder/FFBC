import '../../../home/data/models/user_model.dart';

enum ActivityType {
  follow,
  like,
  reply,
  mention,
}

class ActivityModel {
  final String id;
  final UserModel user;
  final ActivityType type;
  final String? content;
  final DateTime createdAt;
  final bool isRead;

  const ActivityModel({
    required this.id,
    required this.user,
    required this.type,
    this.content,
    required this.createdAt,
    this.isRead = false,
  });

  String get typeText {
    switch (type) {
      case ActivityType.follow:
        return '회원님을 팔로우하기 시작했습니다';
      case ActivityType.like:
        return '회원님의 게시글을 좋아합니다';
      case ActivityType.reply:
        return '회원님의 게시글에 답글을 남겼습니다';
      case ActivityType.mention:
        return '게시글에서 회원님을 언급했습니다';
    }
  }
} 