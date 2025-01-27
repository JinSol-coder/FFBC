import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/memo_model.dart';
import 'memo_repository.dart';

class FirebaseMemoRepository implements MemoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<List<Memo>> getMemos(String userId) async {
    final snapshot = await _firestore
        .collection('memos')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();
    
    return snapshot.docs.map((doc) => Memo.fromFirestore(doc)).toList();
  }

  @override
  Future<Memo> getMemo(String id) async {
    final doc = await _firestore.collection('memos').doc(id).get();
    return Memo.fromFirestore(doc);
  }

  @override
  Future<void> createMemo(Memo memo) async {
    await _firestore.collection('memos').add(memo.toJson());
  }

  @override
  Future<void> updateMemo(Memo memo) async {
    await _firestore.collection('memos').doc(memo.id).update(memo.toJson());
  }

  @override
  Future<void> deleteMemo(String id) async {
    await _firestore.collection('memos').doc(id).delete();
  }

  @override
  Future<List<String>> uploadMedia(List<String> filePaths) async {
    final urls = <String>[];
    for (final path in filePaths) {
      final file = File(path);
      final ref = _storage.ref().child('memos/${DateTime.now().toIso8601String()}_${file.path.split('/').last}');
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }
} 