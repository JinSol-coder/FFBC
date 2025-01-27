import 'package:get/get.dart';
import '../../domain/models/memo.dart';
import '../../domain/repositories/memo_repository.dart';

class MemoSearchController extends GetxController {
  final MemoRepository _repository;
  final RxList<Memo> searchResults = <Memo>[].obs;
  final RxString searchQuery = ''.obs;

  MemoSearchController(this._repository);

  Future<void> search(String query) async {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    try {
      final allMemos = await _repository.getUserMemos();
      final filtered = allMemos.where((memo) {
        return memo.title.toLowerCase().contains(query.toLowerCase()) ||
               memo.content.toLowerCase().contains(query.toLowerCase());
      }).toList();
      searchResults.assignAll(filtered);
    } catch (e) {
      print('Error searching memos: $e');
      throw e;
    }
  }
} 