import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:challenge5/features/cart/viewmodels/cart_viewmodel.dart';
import 'package:challenge5/core/services/storage_service.dart';
import 'package:challenge5/features/cart/models/cart_item.dart';
import 'package:challenge5/features/home/models/menu_item.dart';

void main() {
  late CartViewModel viewModel;
  late StorageService storageService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    storageService = StorageService(prefs);
    viewModel = CartViewModel(storageService);
  });

  group('CartViewModel Tests', () {
    test('초기 상태 확인', () {
      expect(viewModel.items, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.totalPrice, 0);
    });

    test('장바구니에 아이템 추가', () async {
      final testItem = CartItem(
        menu: MenuItem(
          id: '1',
          name: '테스트 메뉴',
          description: '테스트',
          price: 10000,
          imageUrl: '',
          categoryId: '1',
        ),
        quantity: 2,
      );

      await viewModel.addToCart(testItem);
      
      expect(viewModel.items.length, 1);
      expect(viewModel.totalPrice, 20000);
    });
  });
} 