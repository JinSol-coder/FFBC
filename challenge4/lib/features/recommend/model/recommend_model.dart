class RecommendItem {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String trend;
  final String percentage;
  final String recommendation;
  final String? exchangeRate;

  RecommendItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.trend,
    required this.percentage,
    required this.recommendation,
    this.exchangeRate,
  });

  factory RecommendItem.fromJson(Map<String, dynamic> json) {
    return RecommendItem(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      trend: json['trend'] as String,
      percentage: json['percentage'] as String? ?? '',
      recommendation: json['recommendation'] as String,
      exchangeRate: json['exchangeRate'] as String?,
    );
  }
}

class RecommendCategory {
  final String title;
  final List<RecommendItem> items;

  RecommendCategory({
    required this.title,
    required this.items,
  });

  factory RecommendCategory.fromJson(Map<String, dynamic> json) {
    return RecommendCategory(
      title: json['category'] as String,
      items: (json['items'] as List)
          .map((item) => RecommendItem.fromJson(item))
          .toList(),
    );
  }
} 