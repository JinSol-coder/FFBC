import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'comment_item.dart';

class CommentList extends StatelessWidget {
  final String postId;

  const CommentList({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('댓글을 불러오는데 실패했습니다'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('첫 댓글을 남겨보세요!'),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.docs[index];
            return CommentItem(
              postId: postId,
              commentId: doc.id,
              comment: doc.data() as Map<String, dynamic>,
            );
          },
        );
      },
    );
  }
}
