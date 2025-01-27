import 'package:get/get.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/auth_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/memo/memo_binding.dart';
import '../modules/memo/views/memo_list_view.dart';
import '../modules/memo/views/memo_create_view.dart';
import '../modules/memo/views/memo_edit_view.dart';
import '../modules/search/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.auth;

  static final routes = [
    GetPage(
      name: Routes.auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.memos,
      page: () => const MemoListView(),
      binding: MemoBinding(),
    ),
    GetPage(
      name: Routes.memoCreate,
      page: () => const MemoCreateView(),
      binding: MemoBinding(),
    ),
    GetPage(
      name: Routes.memoEdit,
      page: () => const MemoEditView(),
      binding: MemoBinding(),
    ),
    GetPage(
      name: Routes.search,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
  ];
} 