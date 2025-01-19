import 'package:flutter/material.dart';
import '../../../core/services/api_service.dart';
import '../models/category.dart';
import '../models/menu_item.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService apiService;
  
  HomeViewModel({ApiService? apiService}) 
      : apiService = apiService ?? ApiService();

  List<Category> categories = [];
  List<MenuItem> recommendedMenus = [];
  bool isLoading = false;
  String? error;

  Future<void> loadInitialData() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        apiService.get('/categories'),
        apiService.get('/recommended-menus'),
      ]);

      categories = (results[0]['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();

      recommendedMenus = (results[1]['menus'] as List)
          .map((json) => MenuItem.fromJson(json))
          .toList();
    } catch (e) {
      error = '데이터를 불러오는데 실패했습니다.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
} 