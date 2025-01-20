import '../models/menu.dart';

class MenuService {
  final List<Menu> _allMenus = [
    // 한식
    Menu(
      id: 'k1m1',
      restaurantId: 'k1',
      name: '갈비찜',
      description: '매콤달콤 갈비찜',
      price: 25000,
      imageUrl: 'assets/images/foods/한식/한식_갈비찜.png',
      isRecommended: true,
    ),
    Menu(
      id: 'k2m1',
      restaurantId: 'k2',
      name: '김치찌개',
      description: '100% 국내산 재료로 만드는 김치찌개',
      price: 8000,
      imageUrl: 'assets/images/foods/한식/한식_김치찌개.png',
      isRecommended: false,
    ),
    Menu(
      id: 'k3m1',
      restaurantId: 'k3',
      name: '제육볶음',
      description: '매콤달콤 제육볶음',
      price: 9000,
      imageUrl: 'assets/images/foods/한식/한식_제육.png',
      isRecommended: false,
    ),

    // 중식
    Menu(
      id: 'c1m1',
      restaurantId: 'c1',
      name: '짜장면',
      description: '정통 중화식 짜장면',
      price: 7000,
      imageUrl: 'assets/images/foods/중식/중식_짜장면.png',
      isRecommended: true,
    ),
    Menu(
      id: 'c2m1',
      restaurantId: 'c2',
      name: '짬뽕',
      description: '얼큰한 짬뽕',
      price: 8000,
      imageUrl: 'assets/images/foods/중식/중식_짬뽕.png',
      isRecommended: false,
    ),

    // 일식
    Menu(
      id: 'j1m1',
      restaurantId: 'j1',
      name: '돈까스',
      description: '바삭한 돈까스',
      price: 12000,
      imageUrl: 'assets/images/foods/일식/일식_돈까스.png',
      isRecommended: true,
    ),
    Menu(
      id: 'j2m1',
      restaurantId: 'j2',
      name: '라멘',
      description: '진한 라멘',
      price: 9000,
      imageUrl: 'assets/images/foods/일식/일식_라멘.png',
      isRecommended: false,
    ),

    // 피자
    Menu(
      id: 'p1m1',
      restaurantId: 'p1',
      name: '딸기천국 피자',
      description: '딸기x피자의 단짠단짠 싱숭생숭 콜라보',
      price: 18000,
      imageUrl: 'assets/images/foods/피자/딸기피자.png',
      isRecommended: true,
    ),
    Menu(
      id: 'p2m1',
      restaurantId: 'p2',
      name: '치즈피자',
      description: '치즈가 듬뿍',
      price: 15000,
      imageUrl: 'assets/images/foods/피자/치즈피자.png',
      isRecommended: false,
    ),

    // 디저트
    Menu(
      id: 'd1m1',
      restaurantId: 'd1',
      name: '딸기 탕후루',
      description: '달콤한 딸기 탕후루',
      price: 4000,
      imageUrl: 'assets/images/foods/디저트/디저트_탕후루.png',
      isRecommended: true,
    ),
    Menu(
      id: 'd2m1',
      restaurantId: 'd2',
      name: '케이크',
      description: '수제 케이크',
      price: 6000,
      imageUrl: 'assets/images/foods/디저트/케이크.png',
      isRecommended: false,
    ),
  ];

  List<Menu> getMenusByRestaurant(String restaurantId) {
    return _allMenus
        .where((menu) => menu.restaurantId == restaurantId)
        .toList();
  }

  Menu? getMenuById(String menuId) {
    try {
      return _allMenus.firstWhere((menu) => menu.id == menuId);
    } catch (e) {
      return null;
    }
  }
}
