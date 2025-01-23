import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_config.dart';

class InteractionService {
  final FirebaseFirestore _firestore = FirebaseConfig.firestore;

  // 좋아요 토글
  Future<bool> toggleLike(String postId) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final postRef = _firestore.collection('posts').doc(postId);
      final likeRef = postRef.collection('likes').doc(user.uid);

      final likeDoc = await likeRef.get();

      if (likeDoc.exists) {
        // 좋아요 취소
        await likeRef.delete();
        await postRef.update({
          'likes': FieldValue.increment(-1),
        });
        return false;
      } else {
        // 좋아요 추가
        await likeRef.set({
          'userId': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        await postRef.update({
          'likes': FieldValue.increment(1),
        });
        return true;
      }
    } catch (e) {
      throw Exception('좋아요 토글 실패: $e');
    }
  }

  // 댓글 작성
  Future<String> createComment(String postId, String content) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final commentData = {
        'authorId': user.uid,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // 댓글 추가
      final commentRef = await _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .add(commentData);

      // 게시글의 댓글 수 증가
      await _firestore.collection('posts').doc(postId).update({
        'comments': FieldValue.increment(1),
      });

      return commentRef.id;
    } catch (e) {
      throw Exception('댓글 작성 실패: $e');
    }
  }

  // 댓글 수정
  Future<void> updateComment(
      String postId, String commentId, String content) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final commentRef = _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);

      final comment = await commentRef.get();
      if (!comment.exists) throw Exception('댓글을 찾을 수 없음');
      if (comment.data()!['authorId'] != user.uid) throw Exception('권한 없음');

      await commentRef.update({
        'content': content,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('댓글 수정 실패: $e');
    }
  }

  // 댓글 삭제
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final commentRef = _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(commentId);

      final comment = await commentRef.get();
      if (!comment.exists) throw Exception('댓글을 찾을 수 없음');
      if (comment.data()!['authorId'] != user.uid) throw Exception('권한 없음');

      await commentRef.delete();

      // 게시글의 댓글 수 감소
      await _firestore.collection('posts').doc(postId).update({
        'comments': FieldValue.increment(-1),
      });
    } catch (e) {
      throw Exception('댓글 삭제 실패: $e');
    }
  }

  // 댓글 목록 조회
  Future<QuerySnapshot<Map<String, dynamic>>> getComments(
    String postId, {
    DocumentSnapshot? lastDocument,
    int limit = 20,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      return await query.get();
    } catch (e) {
      throw Exception('댓글 목록 조회 실패: $e');
    }
  }
}
