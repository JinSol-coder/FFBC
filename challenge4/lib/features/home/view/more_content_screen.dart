import 'package:flutter/material.dart';
import '../model/content_model.dart';

class MoreContentScreen extends StatelessWidget {
  final String categoryTitle;
  final List<ContentItem> items;

  const MoreContentScreen({
    super.key,
    required this.categoryTitle,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(item.title),
              subtitle: Text(item.description),
              leading: Image.network(
                item.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
} 