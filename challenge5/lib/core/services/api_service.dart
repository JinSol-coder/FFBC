import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiService {
  static const baseUrl = 'https://api.example.com';

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? params,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    
    switch (endpoint) {
      case '/categories':
        return {
          'categories': [
            {
              'id': '1', 
              'name': '한식',
            },
            {
              'id': '2', 
              'name': '중식',
            },
            {
              'id': '3', 
              'name': '일식',
            },
            {
              'id': '4', 
              'name': '양식',
            },
            {
              'id': '5', 
              'name': '치킨',
            },
            {
              'id': '6', 
              'name': '피자',
            },
            {
              'id': '7', 
              'name': '분식',
            },
            {
              'id': '8', 
              'name': '디저트',
            },
          ]
        };
      case '/recommended-menus':
        return {
          'menus': [
            {
              'id': '1',
              'name': '스페셜 치즈 피자',
              'description': '4가지 치즈 블렌딩',
              'price': 25000,
              'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591',
              'categoryId': '6',
              'isHot': true,
              'isEvent': true,
              'discountRate': 30,
            },
            {
              'id': '2',
              'name': '프리미엄 삼겹살',
              'description': '국내산 생삼겹 180g',
              'price': 18000,
              'imageUrl': 'https://images.unsplash.com/photo-1590947132387-155cc02f3212',
              'categoryId': '1',
              'isHot': true,
              'isEvent': false,
              'discountRate': 0,
            },
            {
              'id': '3',
              'name': '로제 떡볶이',
              'description': '매콤 크리미한 특제소스',
              'price': 15000,
              'imageUrl': 'https://images.unsplash.com/photo-1635963662853-f0ef24657507',
              'categoryId': '7',
              'isHot': true,
              'isEvent': true,
              'discountRate': 20,
            },
            {
              'id': '4',
              'name': '마라탕',
              'description': '진한 마라향 가득',
              'price': 16000,
              'imageUrl': 'https://images.unsplash.com/photo-1569718212165-3a8278d5f624',
              'categoryId': '2',
              'isHot': true,
              'isEvent': false,
              'discountRate': 0,
            },
            {
              'id': '5',
              'name': '프리미엄 초밥 세트',
              'description': '신선한 회와 스시',
              'price': 35000,
              'imageUrl': 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c',
              'categoryId': '3',
              'isHot': true,
              'isEvent': true,
              'discountRate': 25,
            },
            {
              'id': '6',
              'name': '양념치킨',
              'description': '특제 양념 치킨',
              'price': 20000,
              'imageUrl': 'https://images.unsplash.com/photo-1575932444877-5106bee2a599',
              'categoryId': '5',
              'isHot': true,
              'isEvent': true,
              'discountRate': 15,
            },
          ]
        };
      case '/restaurants':
        final categoryId = params?['categoryId'] as String;
        final restaurants = _mockRestaurants
            .where((r) => r['categoryId'] == categoryId)
            .toList();
        return {'restaurants': restaurants};
      default:
        throw Exception('Unknown endpoint: $endpoint');
    }
  }

  final _mockRestaurants = [
    // 한식
    {
      'id': 'r1', 'name': '맛있는 김치찌개', 'description': '30년 전통의 김치찌개 전문점',
      'imageUrl': 'https://example.com/kimchi.jpg', 'categoryId': '1',
      'rating': 4.8, 'reviewCount': 1200, 'minOrderAmount': 12000, 'deliveryFee': 3000,
    },
    {
      'id': 'r2', 'name': '할매 순대국', 'description': '청주식 순대국밥 전문',
      'imageUrl': 'https://example.com/sundae.jpg', 'categoryId': '1',
      'rating': 4.5, 'reviewCount': 800, 'minOrderAmount': 8000, 'deliveryFee': 2000,
    },
    {
      'id': 'r3', 'name': '원조 설렁탕', 'description': '100년 전통의 설렁탕',
      'imageUrl': 'https://example.com/seol.jpg', 'categoryId': '1',
      'rating': 4.7, 'reviewCount': 2000, 'minOrderAmount': 10000, 'deliveryFee': 3000,
    },
    // 중식
    {
      'id': 'r4', 'name': '황금성', 'description': '정통 중화요리 전문점',
      'imageUrl': 'https://example.com/chinese.jpg', 'categoryId': '2',
      'rating': 4.7, 'reviewCount': 1500, 'minOrderAmount': 15000, 'deliveryFee': 4000,
    },
    {
      'id': 'r5', 'name': '대박 짬뽕', 'description': '얼큰한 짬뽕 맛집',
      'imageUrl': 'https://example.com/jjam.jpg', 'categoryId': '2',
      'rating': 4.6, 'reviewCount': 1000, 'minOrderAmount': 13000, 'deliveryFee': 3000,
    },
    {
      'id': 'r6', 'name': '만리장성', 'description': '본토 요리의 맛',
      'imageUrl': 'https://example.com/wall.jpg', 'categoryId': '2',
      'rating': 4.4, 'reviewCount': 500, 'minOrderAmount': 16000, 'deliveryFee': 4000,
    },
    // 일식
    {
      'id': 'r7', 'name': '스시히로', 'description': '신선한 회와 스시',
      'imageUrl': 'https://example.com/sushi.jpg', 'categoryId': '3',
      'rating': 4.9, 'reviewCount': 2000, 'minOrderAmount': 20000, 'deliveryFee': 5000,
    },
    {
      'id': 'r8', 'name': '돈카츠 달인', 'description': '바삭한 돈카츠 전문',
      'imageUrl': 'https://example.com/katsu.jpg', 'categoryId': '3',
      'rating': 4.6, 'reviewCount': 1200, 'minOrderAmount': 12000, 'deliveryFee': 3000,
    },
    {
      'id': 'r9', 'name': '라멘 공방', 'description': '정통 라멘 전문점',
      'imageUrl': 'https://example.com/ramen.jpg', 'categoryId': '3',
      'rating': 4.7, 'reviewCount': 1800, 'minOrderAmount': 11000, 'deliveryFee': 3000,
    },
    // 양식
    {
      'id': 'r10', 'name': '파스타 천국', 'description': '수제 파스타 전문',
      'imageUrl': 'https://example.com/pasta.jpg', 'categoryId': '4',
      'rating': 4.5, 'reviewCount': 900, 'minOrderAmount': 15000, 'deliveryFee': 4000,
    },
    {
      'id': 'r11', 'name': '스테이크 하우스', 'description': '최상급 스테이크',
      'imageUrl': 'https://example.com/steak.jpg', 'categoryId': '4',
      'rating': 4.8, 'reviewCount': 1500, 'minOrderAmount': 25000, 'deliveryFee': 5000,
    },
    // 치킨
    {
      'id': 'r12', 'name': '황금 올리브', 'description': '바삭한 후라이드 치킨',
      'imageUrl': 'https://example.com/chicken1.jpg', 'categoryId': '5',
      'rating': 4.7, 'reviewCount': 3000, 'minOrderAmount': 18000, 'deliveryFee': 3000,
    },
    {
      'id': 'r13', 'name': '양념치킨 달인', 'description': '특제 양념 치킨',
      'imageUrl': 'https://example.com/chicken2.jpg', 'categoryId': '5',
      'rating': 4.6, 'reviewCount': 2500, 'minOrderAmount': 17000, 'deliveryFee': 2000,
    },
    // 피자
    {
      'id': 'r14', 'name': '피자 명가', 'description': '수제 도우 피자',
      'imageUrl': 'https://example.com/pizza1.jpg', 'categoryId': '6',
      'rating': 4.5, 'reviewCount': 1800, 'minOrderAmount': 19000, 'deliveryFee': 3000,
    },
    {
      'id': 'r15', 'name': '이탈리안 피자', 'description': '정통 이탈리안 피자',
      'imageUrl': 'https://example.com/pizza2.jpg', 'categoryId': '6',
      'rating': 4.7, 'reviewCount': 1200, 'minOrderAmount': 21000, 'deliveryFee': 4000,
    },
    // 분식
    {
      'id': 'r16', 'name': '엄마손 떡볶이', 'description': '매콤달콤 떡볶이',
      'imageUrl': 'https://example.com/tteok.jpg', 'categoryId': '7',
      'rating': 4.6, 'reviewCount': 2000, 'minOrderAmount': 12000, 'deliveryFee': 2000,
    },
    {
      'id': 'r17', 'name': '김밥천국', 'description': '분식의 모든 것',
      'imageUrl': 'https://example.com/gimbap.jpg', 'categoryId': '7',
      'rating': 4.4, 'reviewCount': 1500, 'minOrderAmount': 10000, 'deliveryFee': 2000,
    },
    // 디저트
    {
      'id': 'r18', 'name': '달콤 카페', 'description': '프리미엄 디저트',
      'imageUrl': 'https://example.com/dessert1.jpg', 'categoryId': '8',
      'rating': 4.8, 'reviewCount': 1000, 'minOrderAmount': 15000, 'deliveryFee': 4000,
    },
    {
      'id': 'r19', 'name': '마카롱 하우스', 'description': '수제 마카롱 전문',
      'imageUrl': 'https://example.com/dessert2.jpg', 'categoryId': '8',
      'rating': 4.7, 'reviewCount': 800, 'minOrderAmount': 12000, 'deliveryFee': 3000,
    },
  ];
} 