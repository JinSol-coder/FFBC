class CartItem {
  final String id;
  final String menuId;
  final String menuName;
  final int price;
  final String imageUrl;
  final int quantity;
  final List<CartItem> sideItems;

  const CartItem({
    required this.id,
    required this.menuId,
    required this.menuName,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.sideItems = const [],
  });

  int get totalPrice {
    int sideTotal =
        sideItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    return (price * quantity) + sideTotal;
  }

  CartItem copyWith({
    String? id,
    String? menuId,
    String? menuName,
    int? price,
    String? imageUrl,
    int? quantity,
    List<CartItem>? sideItems,
  }) {
    return CartItem(
      id: id ?? this.id,
      menuId: menuId ?? this.menuId,
      menuName: menuName ?? this.menuName,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      sideItems: sideItems ?? this.sideItems,
    );
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      menuId: json['menuId'] as String,
      menuName: json['menuName'] as String,
      price: json['price'] as int,
      imageUrl: json['imageUrl'] as String,
      quantity: json['quantity'] as int,
      sideItems: List<CartItem>.from(
          json['sideItems']?.map((x) => CartItem.fromJson(x)) ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'menuId': menuId,
      'menuName': menuName,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'sideItems': sideItems.map((e) => e.toJson()).toList(),
    };
  }
}
