import 'package:flutter/foundation.dart';
import '../model/content_model.dart';
import '../../../data/datasources/dummy_data_source.dart';

class HomeViewModel extends ChangeNotifier {
  List<ContentCategory> _categories = [];
  bool _isLoading = false;

  List<ContentCategory> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchContents() async {
    _isLoading = true;
    notifyListeners();

    try {
      final data = DummyDataSource.getHomeContents();
      _categories = data.map((json) => ContentCategory.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching contents: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
} 