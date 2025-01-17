import 'package:flutter_test/flutter_test.dart';
import 'package:challenge4/features/home/viewmodel/home_viewmodel.dart';
import 'package:challenge4/features/home/model/content_model.dart';

void main() {
  late HomeViewModel viewModel;

  setUp(() {
    viewModel = HomeViewModel();
  });

  test('초기 상태 테스트', () {
    expect(viewModel.categories, isEmpty);
    expect(viewModel.isLoading, isFalse);
  });

  test('fetchContents 성공 시나리오', () async {
    await viewModel.fetchContents();
    
    expect(viewModel.categories.isNotEmpty, true);
    expect(viewModel.isLoading, isFalse);
    
    final firstCategory = viewModel.categories.first;
    expect(firstCategory.title, 'AI 뉴스');
    expect(firstCategory.items.isNotEmpty, true);
  });
} 