import 'package:flutter/material.dart';

import '../../cart/models/cart_item.dart';
import '../../cart/services/cart_service.dart';
import '../services/payment_service.dart';

class PaymentViewModel extends ChangeNotifier {
  final PaymentService _paymentService;
  final CartService _cartService;
  final List<CartItem> cartItems;

  bool _isLoading = false;
  String _selectedMethod = 'card';
  String? _error;

  PaymentViewModel(
    this._paymentService,
    this._cartService,
    this.cartItems,
  );

  bool get isLoading => _isLoading;
  String get selectedMethod => _selectedMethod;
  String? get error => _error;

  int get totalAmount => cartItems.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );

  void updatePaymentMethod(String method) {
    _selectedMethod = method;
    notifyListeners();
  }

  Future<bool> processPayment() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final success = await _paymentService.processPayment(
        items: cartItems,
        paymentMethod: _selectedMethod,
        totalAmount: totalAmount,
      );

      if (success) {
        await _cartService.clearCart();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = '결제 처리 중 오류가 발생했습니다.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = '결제 처리 중 오류가 발생했습니다.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
