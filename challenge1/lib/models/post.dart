import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String authorId;
  final String content;
  final List<String> mediaUrls;
  final int likes;
  final int commentCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Post({
    required this.id,
    required this.authorId,
    required this.content,
    required this.mediaUrls,
    required this.likes,
    required this.commentCount,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      authorId: map['authorId'] ?? '',
      content: map['content'] ?? '',
      mediaUrls: List<String>.from(map['mediaUrls'] ?? []),
      likes: map['likes'] ?? 0,
      commentCount: map['comments'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'authorId': authorId,
      'content': content,
      'mediaUrls': mediaUrls,
      'likes': likes,
      'comments': commentCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
