import 'package:flutter/foundation.dart';
import '../model/search_result_model.dart';
import '../../../data/datasources/dummy_data_source.dart';

class SearchViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _query = '';
  SearchResults? _results;

  bool get isLoading => _isLoading;
  String get query => _query;
  SearchResults? get results => _results;

  Future<void> search(String query) async {
    _query = query;
    if (query.isEmpty) {
      _results = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      // 모든 데이터를 가져와서 검색어로 필터링
      final newsData = DummyDataSource.getNewsContents();
      final recommendData = DummyDataSource.getRecommendations();
      final marketData = DummyDataSource.getHomeContents();

      final news = <SearchResultItem>[];
      final recommendations = <SearchResultItem>[];
      final market = <SearchResultItem>[];

      // 뉴스 검색
      for (var category in newsData) {
        for (var item in category['items']) {
          if (_matchesSearch(item['title'], query) || 
              _matchesSearch(item['description'], query)) {
            news.add(SearchResultItem(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              imageUrl: item['imageUrl'],
              category: category['category'],
              section: '뉴스',
            ));
          }
        }
      }

      // 추천 검색
      for (var category in recommendData) {
        for (var item in category['items']) {
          if (_matchesSearch(item['title'], query) || 
              _matchesSearch(item['description'], query)) {
            recommendations.add(SearchResultItem(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              imageUrl: item['imageUrl'],
              category: category['category'],
              section: '추천',
            ));
          }
        }
      }

      // 시장 데이터 검색
      for (var category in marketData) {
        for (var item in category['items']) {
          if (_matchesSearch(item['title'], query) || 
              _matchesSearch(item['description'], query)) {
            market.add(SearchResultItem(
              id: item['id'],
              title: item['title'],
              description: item['description'],
              imageUrl: item['imageUrl'],
              category: category['category'],
              section: '시장',
            ));
          }
        }
      }

      _results = SearchResults(
        news: news,
        recommendations: recommendations,
        market: market,
      );
    } catch (e) {
      print('Error searching: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _matchesSearch(String text, String query) {
    return text.toLowerCase().contains(query.toLowerCase());
  }
} 