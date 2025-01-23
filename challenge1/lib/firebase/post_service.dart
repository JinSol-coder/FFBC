import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import 'firebase_config.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseConfig.firestore;
  final FirebaseStorage _storage = FirebaseConfig.storage;
  final _uuid = const Uuid();

  // 게시글 작성
  Future<String> createPost({
    required String content,
    List<String>? mediaFiles,
  }) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final postData = {
        'authorId': user.uid,
        'content': content,
        'mediaUrls': mediaFiles ?? [],
        'likes': 0,
        'comments': 0,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

      final docRef = await _firestore.collection('posts').add(postData);
      return docRef.id;
    } catch (e) {
      throw Exception('게시글 작성 실패: $e');
    }
  }

  // 게시글 수정
  Future<void> updatePost({
    required String postId,
    required String content,
    List<String>? newMediaUrls,
  }) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final postRef = _firestore.collection('posts').doc(postId);
      final post = await postRef.get();

      if (!post.exists) throw Exception('게시글을 찾을 수 없음');
      if (post.data()!['authorId'] != user.uid) throw Exception('권한 없음');

      await postRef.update({
        'content': content,
        if (newMediaUrls != null) 'mediaUrls': newMediaUrls,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('게시글 수정 실패: $e');
    }
  }

  // 게시글 삭제
  Future<void> deletePost(String postId) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final postRef = _firestore.collection('posts').doc(postId);
      final post = await postRef.get();

      if (!post.exists) throw Exception('게시글을 찾을 수 없음');
      if (post.data()!['authorId'] != user.uid) throw Exception('권한 없음');

      // 연관된 미디어 파일 삭제
      final mediaUrls = List<String>.from(post.data()!['mediaUrls'] ?? []);
      for (final url in mediaUrls) {
        try {
          await _storage.refFromURL(url).delete();
        } catch (e) {
          print('미디어 파일 삭제 실패: $e');
        }
      }

      // 게시글 문서 삭제
      await postRef.delete();
    } catch (e) {
      throw Exception('게시글 삭제 실패: $e');
    }
  }

  // 게시글 목록 조회 (페이지네이션)
  Future<QuerySnapshot<Map<String, dynamic>>> getPosts({
    DocumentSnapshot? lastDocument,
    int limit = 20,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      return await query.get();
    } catch (e) {
      throw Exception('게시글 목록 조회 실패: $e');
    }
  }

  // 특정 사용자의 게시글 조회
  Future<QuerySnapshot<Map<String, dynamic>>> getUserPosts({
    required String userId,
    DocumentSnapshot? lastDocument,
    int limit = 20,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore
          .collection('posts')
          .where('authorId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      return await query.get();
    } catch (e) {
      throw Exception('사용자 게시글 조회 실패: $e');
    }
  }

  // 미디어 파일 업로드
  Future<List<String>> uploadMediaFiles(List<String> filePaths) async {
    try {
      final user = FirebaseConfig.auth.currentUser;
      if (user == null) throw Exception('인증되지 않은 사용자');

      final List<String> mediaUrls = [];
      for (final filePath in filePaths) {
        final fileName = '${_uuid.v4()}_${filePath.split('/').last}';
        final ref = _storage.ref('posts/${user.uid}/$fileName');

        await ref.putFile(File(filePath));
        final url = await ref.getDownloadURL();
        mediaUrls.add(url);
      }

      return mediaUrls;
    } catch (e) {
      throw Exception('미디어 파일 업로드 실패: $e');
    }
  }
}
