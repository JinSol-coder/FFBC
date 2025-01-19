import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import 'package:flutter/foundation.dart';

class CartViewModel extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => List.unmodifiable(_items);

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(CartItem item) {
    final existingIndex = _items.indexWhere((i) => i.menu.id == item.menu.id);
    if (existingIndex != -1) {
      _items[existingIndex] = CartItem(
        menu: _items[existingIndex].menu,
        quantity: _items[existingIndex].quantity + item.quantity,
      );
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
      return;
    }

    final index = _items.indexOf(item);
    if (index != -1) {
      _items[index] = CartItem(
        menu: item.menu,
        quantity: quantity,
      );
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
} 