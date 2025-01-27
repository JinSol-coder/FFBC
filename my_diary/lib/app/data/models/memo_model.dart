import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  final String id;
  final String title;
  final String content;
  final String userId;
  final List<String> mediaUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  Memo({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.mediaUrls,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'mediaUrls': mediaUrls,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      mediaUrls: List<String>.from(json['mediaUrls']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  factory Memo.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Memo(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      userId: data['userId'] ?? '',
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
    );
  }
} 