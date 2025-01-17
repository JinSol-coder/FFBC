import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../model/news_model.dart';
import '../../../data/api/unsplash_api.dart';

class HomeViewModel extends ChangeNotifier {
  final UnsplashApi _api;
  List<NewsModel> _news = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;

  HomeViewModel({UnsplashApi? api}) : _api = api ?? UnsplashApi();

  List<NewsModel> get news => _news;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchNews({bool refresh = false}) async {
    if (_isLoading) return;
    if (refresh) {
      _currentPage = 1;
      _news.clear();
      _hasMore = true;
    }
    
    if (!_hasMore) return;

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _api.getPhotos(page: _currentPage);
      final newItems = response.map((item) => NewsModel.fromJson(item)).toList();
      
      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _news.addAll(newItems);
        _currentPage++;
      }
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 