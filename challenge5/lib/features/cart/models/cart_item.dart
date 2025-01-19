import '../../home/models/menu_item.dart';

class CartItem {
  final MenuItem menu;
  final int quantity;

  const CartItem({
    required this.menu,
    required this.quantity,
  });

  int get totalPrice => menu.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menu: MenuItem.fromJson(json['menu'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu': menu.toJson(),
      'quantity': quantity,
    };
  }
} 