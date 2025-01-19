import '../../home/models/menu_item.dart';

class CartItem {
  final MenuItem menu;
  final int quantity;

  CartItem({
    required this.menu,
    required this.quantity,
  });

  double get totalPrice => menu.price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'menu': menu.toJson(),
      'quantity': quantity,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      menu: MenuItem.fromJson(json['menu']),
      quantity: json['quantity'],
    );
  }
} 