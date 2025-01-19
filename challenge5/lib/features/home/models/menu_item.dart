class MenuItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final String categoryId;
  final bool isHot;          // 핫한 메뉴 여부
  final bool isEvent;        // 이벤트 진행중 여부
  final int discountRate;    // 할인율

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    this.isHot = false,
    this.isEvent = false,
    this.discountRate = 0,
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
      discountRate: json['discountRate'] as int? ?? 0,
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
    };
  }
} 