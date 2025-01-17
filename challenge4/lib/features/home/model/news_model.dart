class NewsModel {
  final String id;
  final String title;
  final String imageUrl;
  final String description;

  NewsModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['urls']['regular'] as String,
      description: json['description'] as String? ?? '',
    );
  }
} 