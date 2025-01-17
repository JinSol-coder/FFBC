class NewsItem {
  final String id;
  final String title;
  final String imageUrl;
  final String description;

  NewsItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
}

class NewsCategory {
  final String title;
  final List<NewsItem> items;

  NewsCategory({
    required this.title,
    required this.items,
  });

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
      title: json['category'] as String,
      items: (json['items'] as List)
          .map((item) => NewsItem.fromJson(item))
          .toList(),
    );
  }
} 