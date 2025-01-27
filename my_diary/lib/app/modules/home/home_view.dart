import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import '../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Get.toNamed(Routes.search),
          ),
          IconButton(
            onPressed: controller.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(Routes.memos),
              icon: const Icon(Icons.note),
              label: const Text('My Memos'),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(Routes.memoCreate),
              icon: const Icon(Icons.add),
              label: const Text('Create New Memo'),
            ),
          ],
        ),
      ),
    );
  }
} 