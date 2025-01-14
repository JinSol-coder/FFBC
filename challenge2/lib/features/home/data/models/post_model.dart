import 'user_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final String content;
  final List<String>? images;
  final DateTime createdAt;
  final int likesCount;
  final int repliesCount;
  final bool isLiked;

  const PostModel({
    required this.id,
    required this.user,
    required this.content,
    this.images,
    required this.createdAt,
    this.likesCount = 0,
    this.repliesCount = 0,
    this.isLiked = false,
  });
} 