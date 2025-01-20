class MenuItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String categoryId;
  final bool isHot; // 핫한 메뉴 여부
  final bool isEvent; // 이벤트 진행중 여부
  final int? discountRate; // 할인율
  final String restaurantId; // 추가
  final String restaurantName; // 추가

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isHot = false,
    this.isEvent = false,
    this.discountRate,
    required this.restaurantId, // 추가
    required this.restaurantName, // 추가
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      categoryId: json['categoryId'] as String,
      isHot: json['isHot'] as bool? ?? false,
      isEvent: json['isEvent'] as bool? ?? false,
      discountRate: json['discountRate'] as int?,
      restaurantId: json['restaurantId'] as String,
      restaurantName: json['restaurantName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'isHot': isHot,
      'isEvent': isEvent,
      'discountRate': discountRate,
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
    };
  }

  int get discountedPrice {
    if (discountRate == null || discountRate == 0) return price;
    return (price * (100 - discountRate!) / 100).round();
  }

  String get discountRateText =>
      discountRate != null && discountRate! > 0 ? '$discountRate% 할인' : '';
}
