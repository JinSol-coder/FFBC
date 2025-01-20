import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService;
  List<CartItem> _items = [];
  bool _isLoading = false;

  CartViewModel(this._cartService) {
    loadCartItems();
  }

  List<CartItem> get items => _items;
  bool get isLoading => _isLoading;

  int get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);
  int get itemCount => _items.length;

  Future<void> loadCartItems() async {
    _isLoading = true;
    notifyListeners();

    _items = await _cartService.getCartItems();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateQuantity(String itemId, int quantity) async {
    await _cartService.updateQuantity(itemId, quantity);
    await loadCartItems();
  }

  Future<void> removeItem(String itemId) async {
    await _cartService.removeItem(itemId);
    await loadCartItems();
  }

  Future<void> clearCart() async {
    await _cartService.clearCart();
    await loadCartItems();
  }

  Future<void> addItem(CartItem item) async {
    await _cartService.addToCart(item);
    await loadCartItems();
  }
}
