import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

import '../../services/media_service.dart';
import '../../services/notification_service.dart';

class CommentInput extends StatefulWidget {
  final String postId;
  final FocusNode? focusNode;

  const CommentInput({
    Key? key,
    required this.postId,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final TextEditingController _controller = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();
  List<File> _mediaFiles = [];
  bool _isUploading = false;
  double _uploadProgress = 0.0;
  final _mediaService = MediaService();
  final _logger = Logger('CommentInput');
  final _notificationService = NotificationService();

  Future<void> _pickMedia(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _mediaFiles.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      print('미디어 선택 실패: $e');
    }
  }

  Future<List<String>> _uploadMedia() async {
    List<String> mediaUrls = [];
    int totalFiles = _mediaFiles.length;
    int uploadedFiles = 0;

    for (File file in _mediaFiles) {
      try {
        // 미디어 파일 처리
        final processedFiles = await _mediaService.processCommentMedia(file);
        final originalFile = processedFiles['original'];
        final thumbnailFile = processedFiles['thumbnail'];

        if (originalFile == null) continue;

        String fileName = const Uuid().v4();
        String extension = path.extension(originalFile.path);
        String mediaType =
            ['.jpg', '.jpeg', '.png'].contains(extension) ? 'images' : 'videos';

        // 원본 파일 업로드
        final ref = FirebaseStorage.instance.ref().child(
            'comments/${widget.postId}/${user!.uid}/$mediaType/$fileName$extension');

        final uploadTask = ref.putFile(originalFile);
        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          setState(() {
            _uploadProgress = (uploadedFiles +
                    snapshot.bytesTransferred / snapshot.totalBytes) /
                totalFiles;
          });
        });

        await uploadTask;
        String downloadUrl = await ref.getDownloadURL();
        mediaUrls.add(downloadUrl);

        // 썸네일 업로드 (이미지인 경우)
        if (thumbnailFile != null) {
          final thumbRef = FirebaseStorage.instance.ref().child(
              'comments/${widget.postId}/${user!.uid}/thumbnails/thumb_$fileName.jpg');
          await thumbRef.putFile(thumbnailFile);
          String thumbUrl = await thumbRef.getDownloadURL();
          mediaUrls.add(thumbUrl);
        }

        uploadedFiles++;
      } catch (e) {
        _logger.warning('미디어 업로드 실패: $e');
        // 사용자에게 에러 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('미디어 업로드 실패: $e')),
        );
      }
    }

    return mediaUrls;
  }

  Future<void> _submitComment() async {
    if ((_controller.text.trim().isEmpty && _mediaFiles.isEmpty) ||
        user == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      List<String> mediaUrls = [];
      if (_mediaFiles.isNotEmpty) {
        mediaUrls = await _uploadMedia();
      }

      // 게시글 정보 가져오기
      final postDoc = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .get();

      final postData = postDoc.data();
      if (postData == null) return;

      // 댓글 작성
      final commentRef = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.postId)
          .collection('comments')
          .add({
        'postId': widget.postId,
        'authorId': user!.uid,
        'content': _controller.text.trim(),
        'authorProfile': {
          'displayName': user!.displayName,
          'photoURL': user!.photoURL,
          'email': user!.email,
        },
        'mediaUrls': mediaUrls,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'likes': 0,
      });

      // 알림 보내기
      await _notificationService.sendCommentNotification(
        postId: widget.postId,
        postAuthorId: postData['authorId'],
        commentId: commentRef.id,
        commentContent: _controller.text.trim(),
        commentAuthor: {
          'displayName': user!.displayName,
          'photoURL': user!.photoURL,
        },
      );

      _controller.clear();
      setState(() {
        _mediaFiles.clear();
        _isUploading = false;
        _uploadProgress = 0.0;
      });
    } catch (e) {
      _logger.warning('댓글 작성 실패: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_mediaFiles.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _mediaFiles.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _mediaFiles[index],
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            _mediaFiles.removeAt(index);
                          });
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        if (_isUploading) LinearProgressIndicator(value: _uploadProgress),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.photo_camera),
                onPressed: () => _pickMedia(ImageSource.camera),
              ),
              IconButton(
                icon: const Icon(Icons.photo),
                onPressed: () => _pickMedia(ImageSource.gallery),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: widget.focusNode,
                  decoration: const InputDecoration(
                    hintText: '댓글을 입력하세요...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _isUploading ? null : _submitComment,
                icon: const Icon(Icons.send),
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
