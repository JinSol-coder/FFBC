import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/memo_controller.dart';
import '../controllers/auth_controller.dart';

class HomePage extends GetView<MemoController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 메모'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().signOut(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.memos.isEmpty) {
          return Center(
            child: Text('메모가 없습니다.\n새로운 메모를 작성해보세요!',
              textAlign: TextAlign.center,
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.memos.length,
          itemBuilder: (context, index) {
            final memo = controller.memos[index];
            return ListTile(
              title: Text(memo.title),
              subtitle: Text(
                memo.content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Get.toNamed('/memo/${memo.id}'),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/create'),
        child: Icon(Icons.add),
      ),
    );
  }
} 