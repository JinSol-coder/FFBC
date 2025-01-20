import '../models/restaurant.dart';

class RestaurantService {
  final List<Restaurant> _allRestaurants = [
    // 한식
    Restaurant(
      id: 'k1',
      name: '맛있는 갈비찜',
      category: '한식',
      imageUrl: 'assets/images/foods/한식/한식_갈비찜.png',
      rating: 4.5,
      description: '특제 양념으로 만든 갈비찜 전문점',
      isHot: true,
      hasDiscount: true,
      discountRate: 10,
    ),
    Restaurant(
      id: 'k2',
      name: '국밥 한그릇',
      category: '한식',
      imageUrl: 'assets/images/foods/한식/한식_국밥.png',
      rating: 4.3,
      description: '얼큰한 국밥 전문점',
    ),
    Restaurant(
      id: 'k3',
      name: '김치찌개 마을',
      category: '한식',
      imageUrl: 'assets/images/foods/한식/한식_김치찌개.png',
      rating: 4.7,
      description: '100% 국내산 재료로 만드는 김치찌개',
      isHot: true,
    ),
    Restaurant(
      id: 'k4',
      name: '제육 도시락',
      category: '한식',
      imageUrl: 'assets/images/foods/한식/한식_제육.png',
      rating: 4.4,
      description: '매콤달콤 제육볶음',
      hasDiscount: true,
      discountRate: 15,
    ),

    // 중식
    Restaurant(
      id: 'c1',
      name: '황금 짜장면',
      category: '중식',
      imageUrl: 'assets/images/foods/중식/중식_짜장면.png',
      rating: 4.6,
      description: '30년 전통의 중화요리 전문점',
      isHot: true,
    ),
    Restaurant(
      id: 'c2',
      name: '마라 훠궈',
      category: '중식',
      imageUrl: 'assets/images/foods/중식/중식_짬뽕.png',
      rating: 4.8,
      description: '얼얼한 마라향이 특징',
      hasDiscount: true,
      discountRate: 20,
    ),
    Restaurant(
      id: 'c3',
      name: '팔보채 차이나',
      category: '중식',
      imageUrl: 'assets/images/foods/중식/팔보채.png',
      rating: 4.5,
      description: '신선한 해물 요리 전문',
    ),

    // 일식
    Restaurant(
      id: 'j1',
      name: '모모 돈까스',
      category: '일식',
      imageUrl: 'assets/images/foods/일식/일식_돈까스.png',
      rating: 4.6,
      description: '바삭한 돈까스 전문점',
      hasDiscount: true,
      discountRate: 15,
    ),
    Restaurant(
      id: 'j2',
      name: '스시 오마카세',
      category: '일식',
      imageUrl: 'assets/images/foods/일식/일식_초밥.png',
      rating: 4.9,
      description: '신선한 스시 오마카세',
      isHot: true,
    ),
    Restaurant(
      id: 'j3',
      name: '라멘 이치방',
      category: '일식',
      imageUrl: 'assets/images/foods/일식/일식_라멘.png',
      rating: 4.7,
      description: '진한 돈코츠 라멘',
    ),

    // 양식
    Restaurant(
      id: 'w1',
      name: '스테이크 하우스',
      category: '양식',
      imageUrl: 'assets/images/foods/양식/스테이크.png',
      rating: 4.8,
      description: '최상급 스테이크 전문점',
      isHot: true,
    ),
    Restaurant(
      id: 'w2',
      name: '파스타 공방',
      category: '양식',
      imageUrl: 'assets/images/foods/양식/파스타.png',
      rating: 4.5,
      description: '수제 파스타 전문',
      hasDiscount: true,
      discountRate: 25,
    ),
    Restaurant(
      id: 'w3',
      name: '오믈렛 카페',
      category: '양식',
      imageUrl: 'assets/images/foods/양식/오믈렛.png',
      rating: 4.4,
      description: '푹신한 오믈렛 전문',
    ),

    // 치킨
    Restaurant(
      id: 'ch1',
      name: '양념치킨 왕',
      category: '치킨',
      imageUrl: 'assets/images/foods/치킨/양념.png',
      rating: 4.7,
      description: '특제 양념 치킨',
      isHot: true,
    ),
    Restaurant(
      id: 'ch2',
      name: '후라이드 천국',
      category: '치킨',
      imageUrl: 'assets/images/foods/치킨/후라이드.png',
      rating: 4.6,
      description: '바삭한 후라이드 치킨',
      hasDiscount: true,
      discountRate: 20,
    ),
    Restaurant(
      id: 'ch3',
      name: '파닭 하우스',
      category: '치킨',
      imageUrl: 'assets/images/foods/치킨/파닭.png',
      rating: 4.5,
      description: '파채가 듬뿍',
    ),

    // 피자
    Restaurant(
      id: 'p1',
      name: '불고기피자 천국',
      category: '피자',
      imageUrl: 'assets/images/foods/피자/불고기피자.png',
      rating: 4.6,
      description: '불고기의 풍미가 가득',
      isHot: true,
    ),
    Restaurant(
      id: 'p2',
      name: '치즈피자 공방',
      category: '피자',
      imageUrl: 'assets/images/foods/피자/치즈피자.png',
      rating: 4.7,
      description: '치즈가 듬뿍',
      hasDiscount: true,
      discountRate: 30,
    ),
    Restaurant(
      id: 'p3',
      name: '페페로니 하우스',
      category: '피자',
      imageUrl: 'assets/images/foods/피자/페페로니.png',
      rating: 4.5,
      description: '매콤한 페페로니',
    ),

    // 분식
    Restaurant(
      id: 'b1',
      name: '떡볶이 천국',
      category: '분식',
      imageUrl: 'assets/images/foods/분식/떡볶이.png',
      rating: 4.5,
      description: '매콤달콤 떡볶이',
      isHot: true,
    ),
    Restaurant(
      id: 'b2',
      name: '튀김 나라',
      category: '분식',
      imageUrl: 'assets/images/foods/분식/튀김.png',
      rating: 4.4,
      description: '바삭한 튀김',
      hasDiscount: true,
      discountRate: 15,
    ),

    // 디저트
    Restaurant(
      id: 'd1',
      name: '마카롱 하우스',
      category: '디저트',
      imageUrl: 'assets/images/foods/디저트/마카롱.png',
      rating: 4.8,
      description: '수제 마카롱 전문점',
      isHot: true,
    ),
    Restaurant(
      id: 'd2',
      name: '케이크 공방',
      category: '디저트',
      imageUrl: 'assets/images/foods/디저트/케이크.png',
      rating: 4.7,
      description: '수제 케이크 전문',
      hasDiscount: true,
      discountRate: 20,
    ),
    Restaurant(
      id: 'd3',
      name: '당후루 천국',
      category: '디저트',
      imageUrl: 'assets/images/foods/디저트/당후루.png',
      rating: 4.6,
      description: '달콤한 과일 디저트',
    ),
  ];

  List<Restaurant> getAllRestaurants() {
    return _allRestaurants;
  }

  List<Restaurant> getRestaurantsByCategory(String category) {
    return _allRestaurants.where((r) => r.category == category).toList();
  }

  List<Restaurant> getHotRestaurants() {
    return _allRestaurants.where((r) => r.isHot).toList();
  }

  List<Restaurant> getDiscountRestaurants() {
    return _allRestaurants.where((r) => r.hasDiscount).toList();
  }
}
