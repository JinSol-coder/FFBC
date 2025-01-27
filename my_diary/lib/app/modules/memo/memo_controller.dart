import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/memo_model.dart';
import '../../data/repositories/firebase_memo_repository.dart';
import '../auth/auth_controller.dart';

class MemoController extends GetxController {
  final _repository = FirebaseMemoRepository();
  final _authController = Get.find<AuthController>();
  final _imagePicker = ImagePicker();
  
  final RxList<Memo> memos = <Memo>[].obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadMemos();
  }
  
  Future<void> loadMemos() async {
    try {
      isLoading.value = true;
      final userId = _authController.user.value?.uid;
      if (userId != null) {
        memos.value = await _repository.getMemos(userId);
      }
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> createMemo(String title, String content) async {
    try {
      final userId = _authController.user.value?.uid;
      if (userId == null) return;
      
      final memo = Memo(
        id: '',  // Firestore will generate this
        title: title,
        content: content,
        userId: userId,
        mediaUrls: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      
      await _repository.createMemo(memo);
      await loadMemos();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  
  Future<void> updateMemo(Memo memo, {String? title, String? content}) async {
    try {
      final updatedMemo = Memo(
        id: memo.id,
        title: title ?? memo.title,
        content: content ?? memo.content,
        userId: memo.userId,
        mediaUrls: memo.mediaUrls,
        createdAt: memo.createdAt,
        updatedAt: DateTime.now(),
      );
      
      await _repository.updateMemo(updatedMemo);
      await loadMemos();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  
  Future<void> deleteMemo(String id) async {
    try {
      await _repository.deleteMemo(id);
      await loadMemos();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  
  Future<void> addMedia(String memoId) async {
    try {
      final images = await _imagePicker.pickMultiImage();
      if (images.isEmpty) return;
      
      final paths = images.map((image) => image.path).toList();
      final urls = await _repository.uploadMedia(paths);
      
      final memo = memos.firstWhere((m) => m.id == memoId);
      final updatedMemo = Memo(
        id: memo.id,
        title: memo.title,
        content: memo.content,
        userId: memo.userId,
        mediaUrls: [...memo.mediaUrls, ...urls],
        createdAt: memo.createdAt,
        updatedAt: DateTime.now(),
      );
      
      await _repository.updateMemo(updatedMemo);
      await loadMemos();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
} 