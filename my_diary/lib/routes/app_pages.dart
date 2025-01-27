import 'package:get/get.dart';
import '../presentation/pages/login_page.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/memo_detail_page.dart';
import '../presentation/pages/memo_edit_page.dart';
import '../presentation/middleware/auth_middleware.dart';
import '../presentation/bindings/auth_binding.dart';
import '../presentation/bindings/home_binding.dart';
import '../presentation/bindings/search_binding.dart';
import '../presentation/bindings/memo_editor_binding.dart';
// ... 다른 import들

class AppPages {
  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => MainPage(),
      bindings: [
        HomeBinding(),
        SearchBinding(),
        MemoEditorBinding(),
      ],
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/memo/:id',
      page: () => MemoDetailPage(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: '/memo/:id/edit',
      page: () => MemoEditPage(),
      binding: MemoEditorBinding(),
      middlewares: [AuthMiddleware()],
    ),
    // ... 다른 라우트들
  ];
} 