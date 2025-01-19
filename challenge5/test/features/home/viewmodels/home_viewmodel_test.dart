import 'package:flutter_test/flutter_test.dart';
import 'package:challenge5/features/home/viewmodels/home_viewmodel.dart';
import 'package:challenge5/core/services/api_service.dart';

void main() {
  late HomeViewModel viewModel;
  late ApiService apiService;

  setUp(() {
    apiService = ApiService();
    viewModel = HomeViewModel(apiService: apiService);
  });

  group('HomeViewModel Tests', () {
    test('초기 상태 확인', () {
      expect(viewModel.categories, isEmpty);
      expect(viewModel.recommendedMenus, isEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
    });

    test('loadInitialData 성공 시나리오', () async {
      await viewModel.loadInitialData();
      
      expect(viewModel.categories, isNotEmpty);
      expect(viewModel.recommendedMenus, isNotEmpty);
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.error, isNull);
    });
  });
} 