import 'package:get/get.dart';
import '../auth/auth_controller.dart';

class HomeController extends GetxController {
  final AuthController _authController = Get.find<AuthController>();
  
  void signOut() {
    _authController.signOut();
  }
} 