import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() => controller.isLoading.value
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: controller.signInWithGoogle,
              child: Text('Google로 로그인'),
            ),
        ),
      ),
    );
  }
} 