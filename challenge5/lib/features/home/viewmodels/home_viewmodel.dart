import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/menu_item.dart';
import '../models/restaurant.dart';

class HomeViewModel extends ChangeNotifier {
  List<Category> categories = [
    Category(id: '1', name: '한식'),
    Category(id: '2', name: '중식'),
    Category(id: '3', name: '일식'),
    Category(id: '4', name: '양식'),
    Category(id: '5', name: '치킨'),
    Category(id: '6', name: '피자'),
    Category(id: '7', name: '분식'),
    Category(id: '8', name: '디저트'),
  ];

  List<MenuItem> recommendedMenus = [
    MenuItem(
      id: '1',
      name: '치즈 피자',
      description: '모짜렐라 치즈 듬뿍',
      price: 25000,
      imageUrl: 'assets/images/foods/pizza.jpg',
      categoryId: '6',
      isHot: true,
      isEvent: true,
      discountRate: 30,
    ),
    MenuItem(
      id: '2',
      name: '삼겹살',
      description: '국내산 생삼겹 180g',
      price: 18000,
      imageUrl: 'assets/images/foods/pork.jpg',
      categoryId: '1',
      isHot: true,
      isEvent: false,
    ),
    MenuItem(
      id: '3',
      name: '로제 떡볶이',
      description: '매콤 크리미한 특제소스',
      price: 15000,
      imageUrl: 'https://images.unsplash.com/photo-1635963662853-f0ef24657507',
      categoryId: '7',
      isHot: true,
      isEvent: true,
      discountRate: 20,
    ),
    MenuItem(
      id: '4',
      name: '마라탕',
      description: '진한 마라향 가득',
      price: 16000,
      imageUrl: 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
      categoryId: '2',
      isHot: true,
      isEvent: false,
      discountRate: 0,
    ),
    MenuItem(
      id: '5',
      name: '프리미엄 초밥 세트',
      description: '신선한 회와 스시',
      price: 35000,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
      categoryId: '3',
      isHot: true,
      isEvent: true,
      discountRate: 25,
    ),
    MenuItem(
      id: '6',
      name: '양념치킨',
      description: '특제 양념 치킨',
      price: 20000,
      imageUrl: 'https://images.unsplash.com/photo-1575932444877-5106bee2a599',
      categoryId: '5',
      isHot: true,
      isEvent: true,
      discountRate: 15,
    ),
  ];

  List<Restaurant> restaurants = [
    Restaurant(
      id: '1',
      name: '맛있는 한식당',
      description: '정성가득 한식의 맛',
      imageUrl: 'https://images.unsplash.com/photo-1498837167922-ddd27525d352',
      categoryId: '1',
      rating: 4.5,
      reviewCount: 123,
      minOrderAmount: 12000,
      deliveryFee: 3000,
    ),
    Restaurant(
      id: '2',
      name: '중화반점',
      description: '30년 전통의 중식당',
      imageUrl: 'https://images.unsplash.com/photo-1526318896980-cf78c088247c',
      categoryId: '2',
      rating: 4.8,
      reviewCount: 456,
      minOrderAmount: 15000,
      deliveryFee: 2000,
    ),
  ];

  bool isLoading = false;
  String? selectedCategoryId;

  List<MenuItem> get hotMenus => 
    recommendedMenus.where((menu) => menu.isHot).toList();

  List<MenuItem> get eventMenus => 
    recommendedMenus.where((menu) => menu.isEvent).toList();

  Future<void> loadInitialData() async {
    isLoading = true;
    notifyListeners();

    // 더미 데이터를 사용하므로 API 호출 없이 바로 완료
    await Future.delayed(const Duration(milliseconds: 500)); // 로딩 효과를 위한 짧은 딜레이
    
    isLoading = false;
    notifyListeners();
  }

  Future<void> selectCategory(Category category) async {
    selectedCategoryId = category.id;
    notifyListeners();
  }
} 