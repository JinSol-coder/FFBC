import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment_service.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _commentService = CommentService();

  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> newProfile) async {
    try {
      // 사용자 프로필 업데이트
      await _firestore.collection('users').doc(userId).update(newProfile);

      // 연관된 모든 댓글의 프로필 정보도 업데이트
      await _commentService.updateUserComments(userId, {
        'displayName': newProfile['displayName'],
        'photoURL': newProfile['photoURL'],
        'email': newProfile['email'],
      });
    } catch (e) {
      print('프로필 업데이트 실패: $e');
      rethrow;
    }
  }
}
