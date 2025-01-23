import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> sendCommentNotification({
    required String postId,
    required String postAuthorId,
    required String commentId,
    required String commentContent,
    required Map<String, dynamic> commentAuthor,
  }) async {
    try {
      // 자신의 게시글에 댓글을 달 경우 알림을 보내지 않음
      if (_auth.currentUser?.uid == postAuthorId) return;

      await _firestore.collection('notifications').add({
        'type': 'comment',
        'postId': postId,
        'commentId': commentId,
        'recipientId': postAuthorId,
        'senderId': _auth.currentUser?.uid,
        'senderName': commentAuthor['displayName'],
        'senderPhoto': commentAuthor['photoURL'],
        'content': commentContent,
        'isRead': false,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 게시글 작성자의 알림 카운트 증가
      await _firestore.collection('users').doc(postAuthorId).update({
        'unreadNotifications': FieldValue.increment(1),
      });
    } catch (e) {
      print('알림 전송 실패: $e');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).update({
        'isRead': true,
      });

      // 사용자의 알림 카운트 감소
      await _firestore.collection('users').doc(_auth.currentUser?.uid).update({
        'unreadNotifications': FieldValue.increment(-1),
      });
    } catch (e) {
      print('알림 읽음 처리 실패: $e');
    }
  }
}
