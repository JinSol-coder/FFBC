class Restaurant {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double rating;
  final String description;
  final bool isHot;
  final bool hasDiscount;
  final int discountRate;

  Restaurant({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.description,
    this.isHot = false,
    this.hasDiscount = false,
    this.discountRate = 0,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      description: json['description'] as String,
      isHot: json['isHot'] as bool,
      hasDiscount: json['hasDiscount'] as bool,
      discountRate: json['discountRate'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'imageUrl': imageUrl,
      'rating': rating,
      'description': description,
      'isHot': isHot,
      'hasDiscount': hasDiscount,
      'discountRate': discountRate,
    };
  }
}
