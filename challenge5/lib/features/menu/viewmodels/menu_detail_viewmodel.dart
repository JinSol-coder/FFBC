import 'package:flutter/material.dart';
import '../../home/models/menu_item.dart';

class MenuDetailViewModel extends ChangeNotifier {
  final MenuItem menu;
  int quantity = 1;
  
  MenuDetailViewModel(this.menu);

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

  double get totalPrice => menu.price * quantity;
} 