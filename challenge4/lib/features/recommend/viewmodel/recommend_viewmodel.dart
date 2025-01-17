import 'package:flutter/foundation.dart';
import '../model/recommend_model.dart';
import '../../../data/datasources/dummy_data_source.dart';

class RecommendViewModel extends ChangeNotifier {
  List<RecommendCategory> _categories = [];
  bool _isLoading = false;

  List<RecommendCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchRecommendations() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = DummyDataSource.getRecommendations();
      _categories = data.map((json) => RecommendCategory.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching recommendations: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 