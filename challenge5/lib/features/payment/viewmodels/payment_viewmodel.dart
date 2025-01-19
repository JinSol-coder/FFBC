import 'package:flutter/material.dart';
import '../../../core/services/storage_service.dart';
import '../../cart/models/cart_item.dart';

class PaymentViewModel extends ChangeNotifier {
  final StorageService _storageService;
  final List<CartItem> cartItems;
  bool isLoading = false;
  String? error;
  String selectedMethod = '신용카드';

  PaymentViewModel(this._storageService, this.cartItems);

  double get totalAmount => cartItems.fold(
        0,
        (sum, item) => sum + item.totalPrice,
      );

  Future<void> processPayment() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      await _storageService.clearCart();
    } catch (e) {
      error = '결제 처리 중 오류가 발생했습니다.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void updatePaymentMethod(String method) {
    selectedMethod = method;
    notifyListeners();
  }
} 