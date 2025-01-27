import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    
    // 로그인 화면이 아니고 사용자가 인증되지 않은 경우
    if (route != '/login' && authController.user.value == null) {
      return RouteSettings(name: '/login');
    }
    
    // 로그인 화면이고 사용자가 이미 인증된 경우
    if (route == '/login' && authController.user.value != null) {
      return RouteSettings(name: '/home');
    }
    
    return null;
  }
} 