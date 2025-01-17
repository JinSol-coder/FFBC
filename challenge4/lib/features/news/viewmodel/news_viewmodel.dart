import 'package:flutter/foundation.dart';
import '../model/news_category_model.dart';
import '../../../data/datasources/dummy_data_source.dart';

class NewsViewModel extends ChangeNotifier {
  List<NewsCategory> _categories = [];
  bool _isLoading = false;

  List<NewsCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = DummyDataSource.getNewsContents();
      _categories = data.map((json) => NewsCategory.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 