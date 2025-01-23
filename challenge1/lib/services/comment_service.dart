import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  final _firestore = FirebaseFirestore.instance;

  Future<void> updateUserComments(
      String userId, Map<String, dynamic> newProfile) async {
    try {
      // 모든 게시글의 comments 컬렉션을 조회
      final postsSnapshot = await _firestore.collection('posts').get();

      for (var post in postsSnapshot.docs) {
        // 각 게시글의 댓글 중 해당 사용자가 작성한 댓글을 찾아 업데이트
        final commentsQuery = await _firestore
            .collection('posts')
            .doc(post.id)
            .collection('comments')
            .where('authorId', isEqualTo: userId)
            .get();

        final batch = _firestore.batch();

        for (var comment in commentsQuery.docs) {
          batch.update(comment.reference, {
            'authorProfile': newProfile,
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }

        await batch.commit();
      }
    } catch (e) {
      print('댓글 프로필 업데이트 실패: $e');
      rethrow;
    }
  }
}
