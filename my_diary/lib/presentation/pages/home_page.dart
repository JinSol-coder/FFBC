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
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final memo = controller.memos[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => Get.toNamed('/memo/${memo.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        memo.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        memo.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      if (memo.imageUrls.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: memo.imageUrls.length,
                            itemBuilder: (context, imageIndex) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: imageIndex != memo.imageUrls.length - 1 ? 8 : 0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    memo.imageUrls[imageIndex],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[200],
                                        child: const Icon(
                                          Icons.error_outline,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
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