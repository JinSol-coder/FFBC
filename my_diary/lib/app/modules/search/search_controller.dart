import 'package:get/get.dart';
import '../../data/models/memo_model.dart';
import '../../data/repositories/firebase_memo_repository.dart';
import '../auth/auth_controller.dart';

class SearchController extends GetxController {
  final _repository = FirebaseMemoRepository();
  final _authController = Get.find<AuthController>();
  
  final RxString searchQuery = ''.obs;
  final RxList<Memo> searchResults = <Memo>[].obs;
  final RxBool isLoading = false.obs;
  
  void onSearchQueryChanged(String query) {
    searchQuery.value = query;
    _performSearch();
  }
  
  Future<void> _performSearch() async {
    if (searchQuery.value.isEmpty) {
      searchResults.clear();
      return;
    }
    
    try {
      isLoading.value = true;
      final userId = _authController.user.value?.uid;
      if (userId == null) return;
      
      final allMemos = await _repository.getMemos(userId);
      searchResults.value = allMemos.where((memo) {
        final query = searchQuery.value.toLowerCase();
        return memo.title.toLowerCase().contains(query) ||
               memo.content.toLowerCase().contains(query);
      }).toList();
    } finally {
      isLoading.value = false;
    }
  }
} 