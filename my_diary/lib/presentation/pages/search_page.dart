import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/search_controller.dart';

class SearchPage extends GetView<MemoSearchController> {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: '검색어를 입력하세요',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            onChanged: (value) => controller.search(value),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.searchQuery.value.isEmpty) {
          return const Center(
            child: Text('검색어를 입력해주세요'),
          );
        }
        
        if (controller.searchResults.isEmpty) {
          return const Center(
            child: Text('검색 결과가 없습니다'),
          );
        }

        return ListView.builder(
          itemCount: controller.searchResults.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final memo = controller.searchResults[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Get.toNamed('/memo/${memo.id}'),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _highlightText(
                        memo.title,
                        controller.searchQuery.value,
                        const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _highlightText(
                        memo.content,
                        controller.searchQuery.value,
                        const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _formatDate(memo.createdAt),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _highlightText(String text, String query, TextStyle baseStyle, {int? maxLines}) {
    if (query.isEmpty) {
      return Text(
        text,
        style: baseStyle,
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
      );
    }

    final matches = query.toLowerCase();
    final spans = <TextSpan>[];
    var start = 0;

    while (true) {
      final index = text.toLowerCase().indexOf(matches, start);
      if (index == -1) {
        spans.add(TextSpan(
          text: text.substring(start),
          style: baseStyle,
        ));
        break;
      }

      if (index > start) {
        spans.add(TextSpan(
          text: text.substring(start, index),
          style: baseStyle,
        ));
      }

      spans.add(TextSpan(
        text: text.substring(index, index + matches.length),
        style: baseStyle.copyWith(
          backgroundColor: Colors.yellow,
        ),
      ));

      start = index + matches.length;
    }

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: spans,
      ),
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }
} 