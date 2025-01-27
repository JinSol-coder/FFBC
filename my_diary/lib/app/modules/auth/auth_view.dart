import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'My Diary',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: controller.signInWithGoogle,
              icon: const Icon(Icons.login),
              label: const Text('Google로 로그인'),
            ),
          ],
        ),
      ),
    );
  }
} 