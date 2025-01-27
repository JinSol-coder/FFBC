import 'package:get/get.dart';
import '../controllers/search_controller.dart';
import '../../domain/repositories/memo_repository.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    // MemoRepository는 이미 main.dart에서 등록되어 있으므로 
    // MemoSearchController만 등록
    Get.put(MemoSearchController(Get.find<MemoRepository>()));
  }
} 