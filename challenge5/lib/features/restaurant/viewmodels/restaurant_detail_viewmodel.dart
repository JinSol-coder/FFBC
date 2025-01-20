import 'package:flutter/material.dart';

import '../models/menu.dart';
import '../services/menu_service.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  final String restaurantId;
  final MenuService _menuService = MenuService();

  bool isLoading = false;
  List<Menu> _menus = [];
  Map<String, int> _quantities = {};

  RestaurantDetailViewModel(this.restaurantId);

  List<Menu> get mainMenus => _menus.where((m) => m.isRecommended).toList();
  List<Menu> get sideMenus => _menus.where((m) => !m.isRecommended).toList();

  int getQuantity(String menuId) => _quantities[menuId] ?? 0;

  int get totalPrice {
    int total = 0;
    for (var entry in _quantities.entries) {
      final menu = _menus.firstWhere((m) => m.id == entry.key);
      total += menu.price * entry.value;
    }
    return total;
  }

  Future<void> loadMenus() async {
    isLoading = true;
    notifyListeners();

    // 실제로는 비동기로 데이터를 가져올 것
    await Future.delayed(const Duration(milliseconds: 500));
    _menus = _menuService.getMenusByRestaurant(restaurantId);

    isLoading = false;
    notifyListeners();
  }

  void increaseQuantity(String menuId) {
    _quantities[menuId] = (_quantities[menuId] ?? 0) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String menuId) {
    if ((_quantities[menuId] ?? 0) > 0) {
      _quantities[menuId] = _quantities[menuId]! - 1;
      if (_quantities[menuId] == 0) {
        _quantities.remove(menuId);
      }
      notifyListeners();
    }
  }

  Future<void> addToCart(BuildContext context) async {
    // 장바구니에 추가하는 로직 구현 예정
    // CartService를 통해 장바구니에 메뉴 추가
    Navigator.pop(context); // 현재 화면 닫기
  }
}
