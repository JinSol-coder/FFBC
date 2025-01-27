import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../memo_search_controller.dart';
import '../../../widgets/media_widget.dart';

class SearchView extends GetView<MemoSearchController> {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: controller.onSearchQueryChanged,
          decoration: const InputDecoration(
            hintText: '메모 검색...',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.searchQuery.isEmpty) {
          return const Center(child: Text('검색어를 입력하세요'));
        }

        if (controller.searchResults.isEmpty) {
          return const Center(child: Text('검색 결과가 없습니다'));
        }

        return ListView.builder(
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final memo = controller.searchResults[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(memo.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memo.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (memo.mediaUrls.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: memo.mediaUrls.length,
                          itemBuilder: (context, mediaIndex) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: MediaWidget(url: memo.mediaUrls[mediaIndex]),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                onTap: () => Get.toNamed('/memo/edit', arguments: memo),
              ),
            );
          },
        );
      }),
    );
  }
} 