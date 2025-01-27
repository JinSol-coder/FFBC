import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/memo_controller.dart';
import '../../data/repositories/memo_repository_impl.dart';
import '../../domain/repositories/memo_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // FirebaseFirestore 인스턴스 등록
    Get.put<FirebaseFirestore>(FirebaseFirestore.instance);
    
    // MemoRepository 구현체 등록
    Get.put<MemoRepository>(
      MemoRepositoryImpl(Get.find<FirebaseFirestore>()),
    );
    
    // MemoController 등록
    Get.put(MemoController(Get.find<MemoRepository>()));
  }
} 