import 'dart:convert';

class ApiService {
  static const baseUrl = 'https://api.example.com';

  Future<Map<String, dynamic>> get(String endpoint) async {
    await Future.delayed(const Duration(seconds: 1));
    
    switch (endpoint) {
      case '/categories':
        return {
          'categories': [
            {'id': '1', 'name': '한식', 'iconPath': 'assets/icons/korean.png'},
            {'id': '2', 'name': '중식', 'iconPath': 'assets/icons/chinese.png'},
            {'id': '3', 'name': '일식', 'iconPath': 'assets/icons/japanese.png'},
          ]
        };
      case '/recommended-menus':
        return {
          'menus': [
            {
              'id': '1',
              'name': '김치찌개',
              'description': '진한 김치로 끓인 찌개',
              'price': 8000.0,
              'imageUrl': 'https://example.com/kimchi.jpg',
              'categoryId': '1'
            },
            {
              'id': '2',
              'name': '짜장면',
              'description': '진한 춘장으로 만든 짜장면',
              'price': 7000.0,
              'imageUrl': 'https://example.com/jjajang.jpg',
              'categoryId': '2'
            },
          ]
        };
      default:
        throw Exception('Unknown endpoint: $endpoint');
    }
  }
} 