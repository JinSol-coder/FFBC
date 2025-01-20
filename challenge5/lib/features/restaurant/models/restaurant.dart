class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String category;
  final bool hasDiscount;
  final int? discountRate;
  final bool isHot;
  final double rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.category,
    this.hasDiscount = false,
    this.discountRate,
    this.isHot = false,
    required this.rating,
  });
}
