import 'package:flutter_test/flutter_test.dart';
import 'package:challenge5/core/services/api_service.dart';
import 'package:challenge5/features/home/models/category.dart';
import 'package:challenge5/features/home/models/menu_item.dart';
import 'package:challenge5/features/home/models/restaurant.dart';
import 'package:challenge5/features/home/viewmodels/home_viewmodel.dart';

void main() {
  late HomeViewModel viewModel;
  late ApiService apiService;

  setUp(() {
    apiService = ApiService();
    viewModel = HomeViewModel();
  });

  group('HomeViewModel Tests', () {
    test('초기 상태 확인', () {
      expect(viewModel.categories, isNotEmpty);
      expect(viewModel.recommendedMenus, isNotEmpty);
      expect(viewModel.isLoading, isFalse);
    });

    test('카테고리 선택', () async {
      final category = viewModel.categories.first;
      await viewModel.selectCategory(category);
      expect(viewModel.selectedCategoryId, equals(category.id));
    });
  });
} 