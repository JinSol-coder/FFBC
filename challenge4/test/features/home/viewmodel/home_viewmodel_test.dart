import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:challenge4/data/api/unsplash_api.dart';
import 'package:challenge4/features/home/viewmodel/home_viewmodel.dart';

@GenerateMocks([UnsplashApi])
void main() {
  late HomeViewModel viewModel;
  late MockUnsplashApi mockApi;

  setUp(() {
    mockApi = MockUnsplashApi();
    viewModel = HomeViewModel(api: mockApi);
  });

  test('초기 상태 테스트', () {
    expect(viewModel.news, isEmpty);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.hasMore, isTrue);
  });

  test('fetchNews 성공 시나리오', () async {
    when(mockApi.getPhotos(page: 1)).thenAnswer(
      (_) async => [
        {
          'id': '1',
          'title': 'Test Title',
          'urls': {'regular': 'https://example.com/image.jpg'},
          'description': 'Test Description',
        }
      ],
    );

    await viewModel.fetchNews();

    expect(viewModel.news.length, 1);
    expect(viewModel.isLoading, isFalse);
    expect(viewModel.hasMore, isTrue);
  });
} 