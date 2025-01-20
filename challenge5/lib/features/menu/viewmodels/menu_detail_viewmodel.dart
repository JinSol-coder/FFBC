import 'package:flutter/material.dart';

import '../../cart/models/cart_item.dart';
import '../../home/models/menu_item.dart';

class MenuDetailViewModel extends ChangeNotifier {
  final MenuItem menu;
  final String restaurantId;
  final String restaurantName;
  int quantity = 1;
  List<MenuItem> selectedSides = [];

  MenuDetailViewModel({
    required this.menu,
    required this.restaurantId,
    required this.restaurantName,
  });

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

  void toggleSideMenu(MenuItem sideMenu) {
    if (selectedSides.contains(sideMenu)) {
      selectedSides.remove(sideMenu);
    } else {
      selectedSides.add(sideMenu);
    }
    notifyListeners();
  }

  int get totalPrice {
    int sideTotal = selectedSides.fold(0, (sum, item) => sum + item.price);
    return (menu.price * quantity) + sideTotal;
  }

  CartItem toCartItem() {
    return CartItem(
      id: DateTime.now().toString(),
      menuId: menu.id,
      menuName: menu.name,
      price: menu.price,
      imageUrl: menu.imageUrl,
      quantity: quantity,
      sideItems: selectedSides
          .map((side) => CartItem(
                id: DateTime.now().toString(),
                menuId: side.id,
                menuName: side.name,
                price: side.price,
                imageUrl: side.imageUrl,
                quantity: 1,
              ))
          .toList(),
    );
  }
}
