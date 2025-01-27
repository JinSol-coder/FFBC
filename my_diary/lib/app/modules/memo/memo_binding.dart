import 'package:get/get.dart';
import 'memo_controller.dart';

class MemoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MemoController());
  }
} 