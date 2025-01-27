import 'package:get/get.dart';
import '../../domain/models/memo.dart';
import '../../domain/repositories/memo_repository.dart';

class MemoController extends GetxController {
  final MemoRepository _repository;
  final RxList<Memo> memos = <Memo>[].obs;

  MemoController(this._repository);

  @override
  void onInit() {
    super.onInit();
    loadMemos();
  }

  Future<void> loadMemos() async {
    try {
      final userMemos = await _repository.getUserMemos();
      memos.assignAll(userMemos);
    } catch (e) {
      print('Error loading memos: $e');
      // 에러 처리
    }
  }

  Future<Memo> getMemoById(String id) async {
    try {
      return await _repository.getMemoById(id);
    } catch (e) {
      print('Error getting memo: $e');
      throw e;
    }
  }

  Future<void> deleteMemo(String id) async {
    try {
      await _repository.deleteMemo(id);
      await loadMemos(); // 목록 새로고침
    } catch (e) {
      print('Error deleting memo: $e');
      throw e;
    }
  }
} 