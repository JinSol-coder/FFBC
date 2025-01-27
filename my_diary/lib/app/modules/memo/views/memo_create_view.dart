import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../memo_controller.dart';

class MemoCreateView extends GetView<MemoController> {
  const MemoCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Memo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              controller.createMemo(
                titleController.text,
                contentController.text,
              );
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addMedia(''),
        child: const Icon(Icons.attach_file),
      ),
    );
  }
} 