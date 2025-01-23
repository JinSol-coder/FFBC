import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../services/error_service.dart';
import '../profile/profile_detail_dialog.dart';

class CommentItem extends StatefulWidget {
  final Map<String, dynamic> comment;
  final String commentId;
  final String postId;

  const CommentItem({
    Key? key,
    required this.comment,
    required this.commentId,
    required this.postId,
  }) : super(key: key);

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  final TextEditingController _editController = TextEditingController();
  bool isEditing = false;
  final user = FirebaseAuth.instance.currentUser;
  bool _isLiked = false;
  int _likeCount = 0;
  bool _showReplies = false;
  bool _isReplyMode = false;
  final TextEditingController _replyController = TextEditingController();
  final _logger = Logger('CommentItem');

  @override
  void initState() {
    super.initState();
    _editController.text = widget.comment['content'];
    _likeCount = widget.comment['likes'] ?? 0;
    _checkIfLiked();
  }

  Future<void> _checkIfLiked() async {
    if (user == null) return;

    final likeDoc = await FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(widget.commentId)
        .collection('likes')
        .doc(user!.uid)
        .get();

    if (mounted) {
      setState(() {
        _isLiked = likeDoc.exists;
      });
    }
  }

  Future<void> _toggleLike() async {
    if (user == null) return;

    final commentRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(widget.postId)
        .collection('comments')
        .doc(widget.commentId);

    final likeRef = commentRef.collection('likes').doc(user!.uid);

    try {
      if (_isLiked) {
        // 좋아요 취소
        await likeRef.delete();
        await commentRef.update({
          'likes': FieldValue.increment(-1),
        });
        setState(() {
          _isLiked = false;
          _likeCount--;
        });
      } else {
        // 좋아요 추가
        await likeRef.set({
          'userId': user!.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        await commentRef.update({
          'likes': FieldValue.increment(1),
        });
        setState(() {
          _isLiked = true;
          _likeCount++;
        });

        // 좋아요 알림 보내기 (자신의 댓글이 아닌 경우에만)
        if (user!.uid != widget.comment['authorId']) {
          await FirebaseFirestore.instance.collection('notifications').add({
            'type': 'commentLike',
            'postId': widget.postId,
            'commentId': widget.commentId,
            'recipientId': widget.comment['authorId'],
            'senderId': user!.uid,
            'senderName': user!.displayName,
            'senderPhoto': user!.photoURL,
            'content': '회원님의 댓글을 좋아합니다',
            'isRead': false,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      ErrorService.handleError(context, '좋아요', e);
    }
  }

  Future<void> _deleteComment() async {
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .delete();
    } catch (e) {
      print('댓글 삭제 실패: $e');
    }
  }

  Future<void> _updateComment() async {
    if (_editController.text.trim().isEmpty) return;

    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .update({
        'content': _editController.text.trim(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
      setState(() {
        isEditing = false;
      });
    } catch (e) {
      print('댓글 수정 실패: $e');
    }
  }

  Future<void> _submitReply() async {
    if (_replyController.text.trim().isEmpty || user == null) return;

    try {
      // 답글 작성
      final replyRef = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .collection('replies')
          .add({
        'content': _replyController.text.trim(),
        'authorId': user!.uid,
        'authorProfile': {
          'displayName': user!.displayName,
          'photoURL': user!.photoURL,
          'email': user!.email,
        },
        'createdAt': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      // 알림 보내기 (원 댓글 작성자에게)
      if (user!.uid != widget.comment['authorId']) {
        await FirebaseFirestore.instance.collection('notifications').add({
          'type': 'reply',
          'postId': widget.postId,
          'commentId': widget.commentId,
          'replyId': replyRef.id,
          'recipientId': widget.comment['authorId'],
          'senderId': user!.uid,
          'senderName': user!.displayName,
          'senderPhoto': user!.photoURL,
          'content': '회원님의 댓글에 답글을 남겼습니다: ${_replyController.text}',
          'isRead': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      _replyController.clear();
      setState(() {
        _isReplyMode = false;
        _showReplies = true;
      });
    } catch (e) {
      ErrorService.handleError(context, '답글 작성', e);
    }
  }

  void _showProfileDetail() {
    showDialog(
      context: context,
      builder: (context) => ProfileDetailDialog(
        userId: widget.comment['authorId'],
        userProfile: widget.comment['authorProfile'],
      ),
    );
  }

  Widget _buildMediaPreview(List<dynamic> mediaUrls) {
    if (mediaUrls.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mediaUrls.length,
        itemBuilder: (context, index) {
          final url = mediaUrls[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () => _showMediaDetail(url),
              child: Hero(
                tag: url,
                child: CachedNetworkImage(
                  imageUrl: url,
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.error),
                  ),
                  memCacheWidth: 180,
                  memCacheHeight: 180,
                  maxHeightDiskCache: 1280,
                  fadeInDuration: const Duration(milliseconds: 300),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showMediaDetail(String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MediaDetailScreen(url: url),
      ),
    );
  }

  Widget _buildReplies() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .doc(widget.commentId)
          .collection('replies')
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '답글을 불러오는 중 오류가 발생했습니다: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final replies = snapshot.data?.docs ?? [];

        if (replies.isEmpty) {
          return const Text('아직 답글이 없습니다');
        }

        return Column(
          children: replies.map((reply) {
            final replyData = reply.data() as Map<String, dynamic>;
            return Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                      replyData['authorProfile']['photoURL'] ?? '',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          replyData['authorProfile']['displayName'] ?? '익명',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(replyData['content']),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isAuthor = user?.uid == widget.comment['authorId'];

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _showProfileDetail,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          widget.comment['authorProfile']['photoURL'] ?? '',
                        ),
                        radius: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.comment['authorProfile']['displayName'] ?? '익명',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _isLiked ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked ? Colors.red : null,
                        size: 20,
                      ),
                      onPressed: _toggleLike,
                    ),
                    if (_likeCount > 0)
                      Text(
                        _likeCount.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                  ],
                ),
                if (isAuthor) ...[
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      setState(() {
                        isEditing = !isEditing;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: _deleteComment,
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            if (isEditing) ...[
              TextField(
                controller: _editController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing = false;
                        _editController.text = widget.comment['content'];
                      });
                    },
                    child: const Text('취소'),
                  ),
                  TextButton(
                    onPressed: _updateComment,
                    child: const Text('저장'),
                  ),
                ],
              ),
            ] else
              Column(
                children: [
                  Text(widget.comment['content']),
                  const SizedBox(height: 8),
                  _buildMediaPreview(widget.comment['mediaUrls'] ?? []),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  icon: Icon(
                    _showReplies ? Icons.expand_less : Icons.expand_more,
                    size: 20,
                  ),
                  label: const Text('답글'),
                  onPressed: () {
                    setState(() {
                      _showReplies = !_showReplies;
                    });
                  },
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isReplyMode = !_isReplyMode;
                    });
                  },
                  child: const Text('답글 달기'),
                ),
              ],
            ),
            if (_showReplies) _buildReplies(),
            if (_isReplyMode)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _replyController,
                        decoration: const InputDecoration(
                          hintText: '답글을 입력하세요...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 2,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _submitReply,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _editController.dispose();
    _replyController.dispose();
    super.dispose();
  }
}

class MediaDetailScreen extends StatelessWidget {
  final String url;

  const MediaDetailScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Hero(
          tag: url,
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.contain,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
