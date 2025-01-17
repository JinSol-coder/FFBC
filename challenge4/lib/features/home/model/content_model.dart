class ContentItem {
  final String id;
  final String title;
  final String imageUrl;
  final String description;

  ContentItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
}

class ContentCategory {
  final String title;
  final List<ContentItem> items;

  ContentCategory({
    required this.title,
    required this.items,
  });

  factory ContentCategory.fromJson(Map<String, dynamic> json) {
    return ContentCategory(
      title: json['category'] as String,
      items: (json['items'] as List)
          .map((item) => ContentItem.fromJson(item))
          .toList(),
    );
  }
} 