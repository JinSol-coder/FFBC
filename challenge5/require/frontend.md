# project-overview (프로젝트 개요)
- 프로젝트명: 맘마굿
- 개발 프레임워크: Flutter
- UI 스타일: 배달의민족 스타일 참고
- 디자인 테마: 흰색 배경, 주황색 강조
- 아키텍처: MVVM 패턴

# feature-requirements (기능 요구사항)
1. 홈 화면 (HomeView)
   - 상단 카테고리 섹션
     - 가로 스크롤 가능한 카테고리 버튼 리스트
     - 각 카테고리별 아이콘과 텍스트
   - 하단 메뉴 추천 섹션
     - 그리드 레이아웃의 메뉴 카드
     - 메뉴 이미지, 이름, 가격 표시

2. 메뉴 상세 화면 (MenuDetailView)
   - 메뉴 상세 정보 표시
   - 수량 선택 기능
   - "담기" 버튼

3. 장바구니 기능 (CartView)
   - 장바구니 아이템 목록
   - 총 주문 금액 계산
   - 주문하기 버튼

4. 결제 화면 (PaymentView)
   - 주문 정보 확인
   - 결제 수단 선택
   - 결제 처리

# relevant-codes (관련 코드)
주요 코드 구조:
dart
// viewmodels/home_viewmodel.dart
class HomeViewModel extends ChangeNotifier {
final categoryService = CategoryService();
List<Category> categories = [];
Future<void> loadCategories() async {
categories = await categoryService.getCategories();
notifyListeners();
}
}
// models/category.dart
class Category {
final String id;
final String name;
final String iconPath;
Category({
required this.id,
required this.name,
required this.iconPath,
});
}


#Current-file-instruction (현재 파일 구조)
lib/
├── main.dart
├── core/
│ ├── constants/
│ │ ├── app_colors.dart
│ │ └── app_strings.dart
│ ├── services/
│ │ ├── api_service.dart
│ │ └── storage_service.dart
│ └── utils/
│ └── helpers.dart
├── features/
│ ├── home/
│ │ ├── models/
│ │ │ ├── category.dart
│ │ │ └── menu_item.dart
│ │ ├── viewmodels/
│ │ │ └── home_viewmodel.dart
│ │ ├── views/
│ │ │ ├── home_view.dart
│ │ │ └── widgets/
│ │ │ ├── category_list.dart
│ │ │ └── menu_grid.dart
│ │ └── services/
│ │ └── category_service.dart
│ ├── menu/
│ │ ├── viewmodels/
│ │ ├── views/
│ │ └── services/
│ ├── cart/
│ │ ├── viewmodels/
│ │ ├── views/
│ │ └── services/
│ └── payment/
│ ├── viewmodels/
│ ├── views/
│ └── services/
├── shared/
│ ├── widgets/
│ │ ├── custom_button.dart
│ │ └── loading_indicator.dart
│ └── extensions/
└── assets/
├── images/
└── icons/


#rules (규칙)
# rules (규칙)
1. 코드 작성 규칙
   - MVVM 아키텍처 패턴 엄격 준수
   - 각 기능별로 독립적인 모듈화
   - 재사용 가능한 위젯은 shared/widgets에 배치
   - 비즈니스 로직은 ViewModel에서만 처리
   - View는 UI 렌더링만 담당

2. 작업 진행 순서
   1단계: 프로젝트 초기 설정 ✓
   - [x] Flutter 프로젝트 생성
   - [x] 기본 디렉토리 구조 설정
   - [x] 필수 패키지 설치 (provider, http 등)
   - [x] 테마 및 색상 상수 정의

   2단계: 코어 기능 구현 ✓
   - [x] API 서비스 구현 (Mock 데이터 사용)
   - [x] 로컬 스토리지 서비스 구현
   - [x] 공통 위젯 제작
   - [x] 기본 모델 클래스 정의

   3단계: 홈 화면 구현 ✓
   - [x] 카테고리 섹션 UI 구현
   - [x] 메뉴 그리드 UI 구현
   - [x] HomeViewModel 구현
   - [x] 데이터 바인딩 설정

   4단계: 메뉴 상세 및 장바구니 구현 
   - [x] 메뉴 상세 화면 구현
   - [x] 메뉴 상세 ViewModel 구현
   - [x] 장바구니 모델 구현
   - [x] 장바구니 ViewModel 구현
   - [x] 장바구니 UI 구현
   - [x] 장바구니 상태 관리 연동

   5단계: 결제 기능 구현 
   - [x] 결제 화면 UI 구현
   - [x] 결제 프로세스 구현
   - [x] PaymentViewModel 구현

   6단계: 테스트 및 마무리
   - [x] 린터 에러 수정
   - [ ] 단위 테스트 작성
     - [ ] ViewModel 테스트
       - [ ] HomeViewModel 테스트
       - [ ] CartViewModel 테스트
       - [ ] MenuDetailViewModel 테스트
       - [ ] PaymentViewModel 테스트
     - [ ] Service 테스트
       - [ ] ApiService 테스트
       - [ ] StorageService 테스트
   - [ ] UI/UX 테스트
   - [ ] 성능 최적화
   - [ ] 버그 수정