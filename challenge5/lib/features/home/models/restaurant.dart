class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final int minOrderAmount;
  final int deliveryFee;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.minOrderAmount,
    required this.deliveryFee,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      categoryId: json['categoryId'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      minOrderAmount: json['minOrderAmount'] as int,
      deliveryFee: json['deliveryFee'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'rating': rating,
      'reviewCount': reviewCount,
      'minOrderAmount': minOrderAmount,
      'deliveryFee': deliveryFee,
    };
  }
} 