import '../models/memo.dart';

abstract class MemoRepository {
  Future<List<Memo>> getUserMemos();
  Future<Memo> getMemoById(String id);
  Future<void> createMemo(Memo memo);
  Future<void> updateMemo(Memo memo);
  Future<void> deleteMemo(String id);
} 