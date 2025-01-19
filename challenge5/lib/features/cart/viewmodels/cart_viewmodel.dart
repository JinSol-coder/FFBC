import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../../../core/services/storage_service.dart';

class CartViewModel extends ChangeNotifier {
  final StorageService _storageService;
  List<CartItem> items = [];
  bool isLoading = false;

  CartViewModel(this._storageService) {
    loadCartItems();
  }

  Future<void> loadCartItems() async {
    isLoading = true;
    notifyListeners();

    try {
      final cartData = await _storageService.getCartItems();
      items = cartData.map((item) => CartItem.fromJson(item)).toList();
    } catch (e) {
      debugPrint('장바구니 로드 실패: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(CartItem item) async {
    items.add(item);
    await _saveCart();
    notifyListeners();
  }

  Future<void> removeFromCart(CartItem item) async {
    items.remove(item);
    await _saveCart();
    notifyListeners();
  }

  Future<void> clearCart() async {
    items.clear();
    await _storageService.clearCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    await _storageService.saveCartItems(
      items.map((item) => item.toJson()).toList(),
    );
  }

  double get totalPrice => items.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );
} 