import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/models/memo.dart';
import '../../domain/repositories/memo_repository.dart';

class MemoRepositoryImpl implements MemoRepository {
  final FirebaseFirestore _firestore;

  MemoRepositoryImpl(this._firestore);

  @override
  Future<List<Memo>> getUserMemos() async {
    final snapshot = await _firestore.collection('memos').get();
    return snapshot.docs.map((doc) => Memo.fromJson(doc.data())).toList();
  }

  @override
  Future<Memo> getMemoById(String id) async {
    final doc = await _firestore.collection('memos').doc(id).get();
    return Memo.fromJson(doc.data()!);
  }

  @override
  Future<void> createMemo(Memo memo) async {
    await _firestore.collection('memos').doc(memo.id).set(memo.toJson());
  }

  @override
  Future<void> updateMemo(Memo memo) async {
    await _firestore.collection('memos').doc(memo.id).update(memo.toJson());
  }

  @override
  Future<void> deleteMemo(String id) async {
    await _firestore.collection('memos').doc(id).delete();
  }
} 