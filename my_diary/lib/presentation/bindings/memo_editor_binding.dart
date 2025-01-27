import 'package:get/get.dart';
import '../controllers/memo_editor_controller.dart';
import '../../domain/repositories/memo_repository.dart';

class MemoEditorBinding extends Bindings {
  @override
  void dependencies() {
    // MemoRepository는 이미 main.dart에서 등록되어 있으므로
    // MemoEditorController만 등록
    Get.put(MemoEditorController(Get.find<MemoRepository>()));
  }
} 