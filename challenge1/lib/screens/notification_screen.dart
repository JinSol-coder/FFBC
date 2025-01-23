import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../services/notification_service.dart';
import 'post_detail_screen.dart';

class NotificationScreen extends StatelessWidget {
  final _notificationService = NotificationService();

  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notifications')
            .where('recipientId',
                isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('오류가 발생했습니다'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('알림이 없습니다'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final notification = snapshot.data!.docs[index];
              final data = notification.data() as Map<String, dynamic>;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data['senderPhoto'] ?? ''),
                ),
                title: Text(data['senderName'] ?? '알 수 없는 사용자'),
                subtitle: Text(data['content']),
                trailing: Text(
                  timeago.format(
                    (data['createdAt'] as Timestamp).toDate(),
                    locale: 'ko',
                  ),
                ),
                onTap: () async {
                  // 알림 읽음 처리
                  await _notificationService
                      .markNotificationAsRead(notification.id);

                  // 해당 게시글로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PostDetailScreen(postId: data['postId']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
