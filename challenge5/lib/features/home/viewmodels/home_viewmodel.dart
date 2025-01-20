import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/restaurant.dart';
import '../services/restaurant_service.dart';

class HomeViewModel extends ChangeNotifier {
  final RestaurantService _restaurantService;

  HomeViewModel(this._restaurantService) {
    loadInitialData();
  }

  String _selectedCategory = '한식';
  List<Restaurant> _restaurants = [];
  List<Restaurant> _hotRestaurants = [];
  List<Restaurant> _discountRestaurants = [];

  String get selectedCategory => _selectedCategory;
  List<Restaurant> get restaurants => _restaurants;
  List<Restaurant> get hotRestaurants => _hotRestaurants;
  List<Restaurant> get discountRestaurants => _discountRestaurants;

  List<Category> categories = [
    Category(id: '1', name: '한식', icon: Icons.rice_bowl),
    Category(id: '2', name: '중식', icon: Icons.ramen_dining),
    Category(id: '3', name: '일식', icon: Icons.set_meal),
    Category(id: '4', name: '양식', icon: Icons.restaurant),
    Category(id: '5', name: '치킨', icon: Icons.kebab_dining),
    Category(id: '6', name: '피자', icon: Icons.local_pizza),
    Category(id: '7', name: '분식', icon: Icons.lunch_dining),
    Category(id: '8', name: '디저트', icon: Icons.cake),
  ];

  bool isLoading = false;

  Future<void> loadInitialData() async {
    isLoading = true;
    notifyListeners();

    _hotRestaurants = _restaurantService.getHotRestaurants();
    _discountRestaurants = _restaurantService.getDiscountRestaurants();
    _restaurants =
        _restaurantService.getRestaurantsByCategory(_selectedCategory);

    print('Hot Restaurants: ${_hotRestaurants.length}');
    print('Discount Restaurants: ${_discountRestaurants.length}');

    isLoading = false;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    _restaurants = _restaurantService.getRestaurantsByCategory(category);
    notifyListeners();
  }

  void loadSpecialSections() {
    _hotRestaurants = _restaurantService.getHotRestaurants();
    _discountRestaurants = _restaurantService.getDiscountRestaurants();
    notifyListeners();
  }

  void searchRestaurants(String query) {
    // 검색 로직 구현
    if (query.isEmpty) {
      loadInitialData();
      return;
    }

    final searchLower = query.toLowerCase();
    _restaurants = _restaurantService.getAllRestaurants().where((restaurant) {
      return restaurant.name.toLowerCase().contains(searchLower) ||
          restaurant.description.toLowerCase().contains(searchLower);
    }).toList();

    notifyListeners();
  }
}
