import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_item.dart';

class CartService extends ChangeNotifier {
  static const String _cartKey = 'cart_items';
  final SharedPreferences _prefs;
  final List<CartItem> _items = [];

  CartService(this._prefs);

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  Future<List<CartItem>> getCartItems() async {
    final String? cartJson = _prefs.getString(_cartKey);
    if (cartJson == null) return [];

    final List<dynamic> cartList = jsonDecode(cartJson);
    return cartList.map((item) => CartItem.fromJson(item)).toList();
  }

  Future<void> addToCart(CartItem item) async {
    final items = await getCartItems();
    final existingIndex = items.indexWhere((i) => i.menuId == item.menuId);

    if (existingIndex >= 0) {
      items[existingIndex] = items[existingIndex].copyWith(
        quantity: items[existingIndex].quantity + item.quantity,
      );
    } else {
      items.add(item);
    }

    await _saveCart(items);
    notifyListeners();
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    final items = await getCartItems();
    final index = items.indexWhere((item) => item.id == itemId);

    if (index >= 0) {
      if (quantity > 0) {
        items[index] = items[index].copyWith(quantity: quantity);
      } else {
        items.removeAt(index);
      }
      await _saveCart(items);
      notifyListeners();
    }
  }

  Future<void> removeItem(String itemId) async {
    final items = await getCartItems();
    items.removeWhere((item) => item.id == itemId);
    await _saveCart(items);
    notifyListeners();
  }

  Future<void> clearCart() async {
    await _prefs.remove(_cartKey);
    notifyListeners();
  }

  Future<void> _saveCart(List<CartItem> items) async {
    final cartJson = jsonEncode(items.map((e) => e.toJson()).toList());
    await _prefs.setString(_cartKey, cartJson);
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void updateItem(CartItem item) {
    final index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index] = item;
      notifyListeners();
    }
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
