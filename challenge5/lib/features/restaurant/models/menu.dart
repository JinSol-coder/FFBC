class Menu {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final bool isRecommended;
  final List<Menu> sideMenus;

  const Menu({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isRecommended = false,
    this.sideMenus = const [],
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as String,
      restaurantId: json['restaurantId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      isRecommended: json['isRecommended'] as bool? ?? false,
      sideMenus: List<Menu>.from(
          json['sideMenus']?.map((x) => Menu.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isRecommended': isRecommended,
      'sideMenus': sideMenus.map((x) => x.toJson()).toList(),
    };
  }
}
