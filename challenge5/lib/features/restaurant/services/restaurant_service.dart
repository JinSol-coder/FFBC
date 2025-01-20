import '../models/restaurant.dart';

class RestaurantService {
  final List<Restaurant> _restaurants = [
    // 한식
    Restaurant(
      id: 'k1',
      name: '맛있는 갈비찜',
      description: '매콤달콤 갈비찜 전문점',
      imageUrl: 'assets/images/foods/한식/한식_갈비찜.png',
      category: '한식',
      hasDiscount: true,
      discountRate: 10,
      isHot: true,
      rating: 4.8,
    ),
    Restaurant(
      id: 'k2',
      name: '김치찌개 마을',
      description: '100% 국내산 재료로 만드는 김치찌개',
      imageUrl: 'assets/images/foods/한식/한식_김치찌개.png',
      category: '한식',
      hasDiscount: false,
      isHot: true,
      rating: 4.7,
    ),
    Restaurant(
      id: 'k3',
      name: '제육 도시락',
      description: '매콤달콤 제육볶음',
      imageUrl: 'assets/images/foods/한식/한식_제육.png',
      category: '한식',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.4,
    ),
    Restaurant(
      id: 'k4',
      name: '밥도둑 갈비왕',
      description: '부드러운 갈비찜',
      imageUrl: 'assets/images/foods/한식/한식_갈비찜.png',
      category: '한식',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.4,
    ),

    // 중식
    Restaurant(
      id: 'c1',
      name: '중식 짜장면',
      description: '정통 중화식 짜장면',
      imageUrl: 'assets/images/foods/중식/중식_짜장면.png',
      category: '중식',
      hasDiscount: true,
      discountRate: 15,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'c2',
      name: '중식 짬뽕',
      description: '얼큰한 짬뽕',
      imageUrl: 'assets/images/foods/중식/중식_짬뽕.png',
      category: '중식',
      hasDiscount: true,
      discountRate: 20,
      isHot: false,
      rating: 4.5,
    ),
    Restaurant(
      id: 'c3',
      name: '중식 팔보채',
      description: '해물 팔보채',
      imageUrl: 'assets/images/foods/중식/팔보채.png',
      category: '중식',
      hasDiscount: false,
      isHot: true,
      rating: 4.5,
    ),

    // 일식
    Restaurant(
      id: 'j1',
      name: '일식 돈까스',
      description: '바삭한 돈까스',
      imageUrl: 'assets/images/foods/일식/일식_돈까스.png',
      category: '일식',
      hasDiscount: true,
      discountRate: 20,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'j2',
      name: '일식 라멘',
      description: '진한 라멘',
      imageUrl: 'assets/images/foods/일식/일식_라멘.png',
      category: '일식',
      hasDiscount: false,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'j3',
      name: '일식 초밥',
      description: '신선한 초밥',
      imageUrl: 'assets/images/foods/일식/일식_초밥.png',
      category: '일식',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.5,
    ),

    // 양식
    Restaurant(
      id: 'w1',
      name: '양식 스테이크',
      description: '육즙 가득 스테이크',
      imageUrl: 'assets/images/foods/양식/스테이크.png',
      category: '양식',
      hasDiscount: true,
      discountRate: 20,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'w2',
      name: '양식 오믈렛',
      description: '부드러운 오믈렛',
      imageUrl: 'assets/images/foods/양식/오믈렛.png',
      category: '양식',
      hasDiscount: false,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'w3',
      name: '양식 파스타',
      description: '알덴테 파스타',
      imageUrl: 'assets/images/foods/양식/파스타.png',
      category: '양식',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.5,
    ),

    // 치킨
    Restaurant(
      id: 'ch1',
      name: '치킨 양념',
      description: '달콤매콤 양념치킨',
      imageUrl: 'assets/images/foods/치킨/양념.png',
      category: '치킨',
      hasDiscount: true,
      discountRate: 20,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'ch2',
      name: '치킨 파닭',
      description: '바삭한 파닭',
      imageUrl: 'assets/images/foods/치킨/파닭.png',
      category: '치킨',
      hasDiscount: false,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'ch3',
      name: '치킨 후라이드',
      description: '바삭한 후라이드',
      imageUrl: 'assets/images/foods/치킨/후라이드.png',
      category: '치킨',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.5,
    ),

    // 피자
    Restaurant(
      id: 'p1',
      name: '딸기천국 피자',
      description: '딸기x피자의 단짠단짠 싱숭생숭 콜라보',
      imageUrl: 'assets/images/foods/피자/딸기피자.png',
      category: '피자',
      hasDiscount: false,
      isHot: true,
      rating: 4.6,
    ),
    Restaurant(
      id: 'p2',
      name: '치즈피자 공방',
      description: '치즈가 듬뿍',
      imageUrl: 'assets/images/foods/피자/치즈피자.png',
      category: '피자',
      hasDiscount: true,
      discountRate: 30,
      isHot: false,
      rating: 4.7,
    ),
    Restaurant(
      id: 'p3',
      name: '페페로니 하우스',
      description: '매콤한 페페로니',
      imageUrl: 'assets/images/foods/피자/페페로니.png',
      category: '피자',
      hasDiscount: false,
      isHot: false,
      rating: 4.5,
    ),

    // 분식
    Restaurant(
      id: 'b1',
      name: '동네분식 동팔이네 떡볶이',
      description: '매콤달콤 떡볶이',
      imageUrl: 'assets/images/foods/분식/떡볶이.png',
      category: '분식',
      hasDiscount: true,
      discountRate: 20,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'b2',
      name: '진가네 뭐가남아 떡볶이',
      description: '치즈 떡볶이',
      imageUrl: 'assets/images/foods/분식/떡볶이2.png',
      category: '분식',
      hasDiscount: false,
      isHot: true,
      rating: 4.5,
    ),
    Restaurant(
      id: 'b3',
      name: '튀김의 신',
      description: '바삭한 튀김',
      imageUrl: 'assets/images/foods/분식/튀김.png',
      category: '분식',
      hasDiscount: true,
      discountRate: 15,
      isHot: false,
      rating: 4.3,
    ),

    // 디저트
    Restaurant(
      id: 'd1',
      name: '달콤 탕후루',
      description: '신선한 과일로 만드는 탕후루',
      imageUrl: 'assets/images/foods/디저트/디저트_탕후루.png',
      category: '디저트',
      hasDiscount: true,
      discountRate: 15,
      isHot: true,
      rating: 4.7,
    ),
    Restaurant(
      id: 'd2',
      name: '케이크 공방',
      description: '수제 케이크 전문점',
      imageUrl: 'assets/images/foods/디저트/케이크.png',
      category: '디저트',
      hasDiscount: true,
      discountRate: 20,
      isHot: false,
      rating: 4.7,
    ),
    Restaurant(
      id: 'd3',
      name: '탕후루 천국',
      description: '달콤한 과일 디저트',
      imageUrl: 'assets/images/foods/디저트/탕후루.png',
      category: '디저트',
      hasDiscount: false,
      isHot: false,
      rating: 4.6,
    ),
  ];

  List<Restaurant> getAllRestaurants() => _restaurants;

  List<Restaurant> getRestaurantsByCategory(String category) {
    return _restaurants
        .where((restaurant) => restaurant.category == category)
        .toList();
  }

  List<Restaurant> getHotRestaurants() {
    // 핫한 메뉴로 선정할 식당들
    final hotRestaurants = [
      _restaurants.firstWhere((r) => r.id == 'k1'), // 갈비찜
      _restaurants.firstWhere((r) => r.id == 'j1'), // 돈까스
      _restaurants.firstWhere((r) => r.id == 'p1'), // 딸기천국 피자
      _restaurants.firstWhere((r) => r.id == 'd1'), // 탕후루
      _restaurants.firstWhere((r) => r.id == 'c1'), // 짜장면
    ];

    return hotRestaurants;
  }

  List<Restaurant> getDiscountRestaurants() {
    // 할인 이벤트 메뉴로 선정할 식당들
    final discountRestaurants = [
      _restaurants.firstWhere((r) => r.id == 'k2'), // 김치찌개
      _restaurants.firstWhere((r) => r.id == 'j2'), // 라멘
      _restaurants.firstWhere((r) => r.id == 'p2'), // 치즈피자
      _restaurants.firstWhere((r) => r.id == 'd2'), // 케이크
      _restaurants.firstWhere((r) => r.id == 'c2'), // 짬뽕
    ];

    return discountRestaurants;
  }
}
