import 'package:flutter/foundation.dart';
import '../model/search_history_model.dart';
import '../../../data/api/unsplash_api.dart';
import '../../home/model/news_model.dart';

class SearchViewModel extends ChangeNotifier {
  final UnsplashApi _api;
  List<NewsModel> _searchResults = [];
  List<SearchHistoryModel> _searchHistory = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String _currentQuery = '';

  SearchViewModel({UnsplashApi? api}) : _api = api ?? UnsplashApi();

  List<NewsModel> get searchResults => _searchResults;
  List<SearchHistoryModel> get searchHistory => _searchHistory;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> search(String query, {bool refresh = false}) async {
    if (_isLoading) return;
    if (refresh || query != _currentQuery) {
      _currentPage = 1;
      _searchResults.clear();
      _hasMore = true;
      _currentQuery = query;
      
      // 검색 기록 추가
      _addToHistory(query);
    }
    
    if (!_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.searchPhotos(query, page: _currentPage);
      final newItems = response.map((item) => NewsModel.fromJson(item)).toList();
      
      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _searchResults.addAll(newItems);
        _currentPage++;
      }
    } catch (e) {
      print('Error searching photos: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _addToHistory(String query) {
    final history = SearchHistoryModel(
      query: query,
      timestamp: DateTime.now(),
    );
    
    _searchHistory.insert(0, history);
    if (_searchHistory.length > 10) {
      _searchHistory.removeLast();
    }
    notifyListeners();
  }

  void clearHistory() {
    _searchHistory.clear();
    notifyListeners();
  }
} 