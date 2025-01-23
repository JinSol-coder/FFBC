import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/post.dart'; // Post 모델 import 필요
import '../widgets/comment/comment_input.dart';
import '../widgets/comment/comment_list.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('오류가 발생했습니다'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('게시글을 찾을 수 없습니다'));
        }

        final post = Post.fromMap(
          snapshot.data!.data() as Map<String, dynamic>,
          snapshot.data!.id,
        );

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('게시물'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  // TODO: 게시물 메뉴 구현
                },
              ),
            ],
          ),
          body: Column(
            children: [
              // 게시글 내용과 댓글 목록
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 게시글 이미지
                      AspectRatio(
                        aspectRatio: 1,
                        child: PageView.builder(
                          itemCount: post.mediaUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              post.mediaUrls[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),

                      // 액션 버튼들
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.favorite_border),
                              onPressed: () {
                                // TODO: 좋아요 기능 구현
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.chat_bubble_outline),
                              onPressed: () {
                                _commentFocusNode.requestFocus();
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.share_outlined),
                              onPressed: () {
                                // TODO: 공유 기능 구현
                              },
                            ),
                          ],
                        ),
                      ),

                      // 좋아요 수
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '좋아요 ${post.likes}개',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // 게시글 내용
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(post.content),
                      ),

                      // 댓글 목록
                      CommentList(postId: widget.postId),
                    ],
                  ),
                ),
              ),

              // 하단 고정 댓글 입력창
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 0.5,
                    ),
                  ),
                ),
                child: CommentInput(
                  postId: widget.postId,
                  focusNode: _commentFocusNode,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
