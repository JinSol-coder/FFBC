import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'routes/app_pages.dart';
import 'presentation/controllers/auth_controller.dart';
import 'data/repositories/memo_repository_impl.dart';
import 'domain/repositories/memo_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 전역 의존성 등록
  Get.put<FirebaseFirestore>(FirebaseFirestore.instance);
  Get.put<MemoRepository>(
    MemoRepositoryImpl(Get.find<FirebaseFirestore>()),
    permanent: true,
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '메모 앱',
      initialRoute: '/login',  // 초기 라우트를 로그인으로 설정
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController(), permanent: true);  // 인증 컨트롤러를 영구적으로 등록
      }),
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
