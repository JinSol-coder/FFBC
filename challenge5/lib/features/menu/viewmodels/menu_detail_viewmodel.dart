import 'package:flutter/material.dart';
import '../../home/models/menu_item.dart';
import '../../cart/models/cart_item.dart';

class MenuDetailViewModel extends ChangeNotifier {
  final MenuItem menu;
  int quantity = 1;
  
  MenuDetailViewModel({required this.menu});

  void incrementQuantity() {
    quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
  }

  int get totalPrice => menu.price * quantity;

  CartItem toCartItem() {
    return CartItem(
      menu: menu,
      quantity: quantity,
    );
  }
} 