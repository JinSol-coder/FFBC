import 'package:shared_preferences/shared_preferences.dart';

import '../../cart/models/cart_item.dart';

class PaymentService {
  final SharedPreferences _prefs;
  static const String _orderHistoryKey = 'order_history';

  PaymentService(this._prefs);

  Future<bool> processPayment({
    required List<CartItem> items,
    required String paymentMethod,
    required int totalAmount,
  }) async {
    try {
      // 실제로는 여기서 결제 API를 호출할 것입니다.
      await Future.delayed(const Duration(seconds: 2)); // 결제 처리 시뮬레이션

      // 주문 내역 저장
      final orderHistory = _prefs.getStringList(_orderHistoryKey) ?? [];
      final order = {
        'orderId': DateTime.now().millisecondsSinceEpoch.toString(),
        'items': items.map((e) => e.toJson()).toList(),
        'totalAmount': totalAmount,
        'paymentMethod': paymentMethod,
        'orderDate': DateTime.now().toIso8601String(),
      };
      orderHistory.add(order.toString());
      await _prefs.setStringList(_orderHistoryKey, orderHistory);

      return true;
    } catch (e) {
      return false;
    }
  }
}
