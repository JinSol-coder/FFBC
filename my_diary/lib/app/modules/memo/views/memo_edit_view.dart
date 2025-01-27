import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/memo_model.dart';
import '../memo_controller.dart';

class MemoEditView extends GetView<MemoController> {
  const MemoEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final memo = Get.arguments as Memo;
    final titleController = TextEditingController(text: memo.title);
    final contentController = TextEditingController(text: memo.content);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Memo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              controller.updateMemo(
                memo,
                title: titleController.text,
                content: contentController.text,
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
            if (memo.mediaUrls.isNotEmpty) ...[
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: memo.mediaUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(memo.mediaUrls[index]),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.addMedia(memo.id),
        child: const Icon(Icons.attach_file),
      ),
    );
  }
} 