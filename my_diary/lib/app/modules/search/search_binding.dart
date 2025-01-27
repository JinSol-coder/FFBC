import 'package:get/get.dart';
import 'memo_search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MemoSearchController());
  }
} 