import '../models/memo_model.dart';

abstract class MemoRepository {
  Future<List<Memo>> getMemos(String userId);
  Future<Memo> getMemo(String id);
  Future<void> createMemo(Memo memo);
  Future<void> updateMemo(Memo memo);
  Future<void> deleteMemo(String id);
  Future<List<String>> uploadMedia(List<String> filePaths);
} 