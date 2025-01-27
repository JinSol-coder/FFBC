import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../memo_controller.dart';
import 'memo_create_view.dart';

class MemoListView extends GetView<MemoController> {
  const MemoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Memos'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        
        if (controller.memos.isEmpty) {
          return const Center(child: Text('No memos yet'));
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
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => controller.deleteMemo(memo.id),
              ),
              onTap: () => Get.toNamed('/memo/edit', arguments: memo),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const MemoCreateView()),
        child: const Icon(Icons.add),
      ),
    );
  }
} 