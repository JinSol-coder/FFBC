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

# 1차 수정

1. [x] 상단 앱 이름 써있는 곳은 엄청 밝은 회색으로 바꾼 후, 맘마굿 글씨를 주황색으로 바꿔주고 트렌디한 글씨체로 바꿔주세요.

2. [x] 상단 메뉴 카테고리 섹션에서  
        한식, 중식, 일식, 양식,
       치킨, 피자, 분식, 디저트
       순으로 카테고리 배열 밑 카테고리에 맞는 아이콘을 넣어주세요

3. [x] 메뉴 카테고리 섹션 위에 사용자들에게 무언가를 먹고싶냐고 물어보는 텍스트 "오늘은 무슨 맘마?" 를 넣어주세요

4. [x] 카테고리 메뉴별 임의의 식당을 3개~5개 정도 만들어주세요. 그리고 카테고리를 눌렀을때 해당 식당들이 나오게끔 해주시고, 이미지도 임의로 넣어주세요.

5. [x] 메뉴 추천 섹션에서 지금 핫한 메뉴, 이벤트 진행중인 메뉴 등 필터링을 추가해주세요

6. [x] 장바구니를 눌렀을 시, 내가 담은 메뉴가 보이는 페이지를 만들고 보이게 해주세요. 그리고 담은 메뉴 개수 조정 및 취소 버튼도 구성해주고 기능까지 구현해주세요.

7. [x] 전체적인 레이아웃을 조정해주세요. 사용자가 보기 편하게 해야 합니다.
   - [x] 공통 스타일 정의 (AppStyles)
   - [x] 카테고리 리스트 UI 개선
   - [x] 메뉴 그리드 UI 개선
   - [x] 식당 리스트 UI 개선
   - [x] 애니메이션 효과 추가
   - [x] 터치 피드백 개선
   - [x] 여백과 간격 조정
   - [x] 그림자와 테두리 효과 추가

# 3차 수정

1. 카테고리 별 음식점이 분류가 안되있고 공통 식당밖에 없습니다. 카테고리 별 식당 3~4개 만들어주세요. 해당 이미지는 assets/images/foods/ 폴더에 있습니다. 이 폴더에 있는 이미지를 사용해주세요.

2. 특별 할인 이벤트 섹션과 지금 핫한 메뉴 둘다 카테고리 음식점 중에서 랜덤으로 뽑아주세요.

# 4차 수정

1. [x] 음식점 클릭 시 메뉴 담기 화면으로 넘어가고 상품 개수 조정 및 취소 버튼도 구성해주고 기능까지 구현해주세요. 그리고 음식에 맞는 사이드 추가도 구현해주면 좋아요.

   - [x] 메뉴 모델 구현
   - [x] 메뉴 서비스 구현
   - [x] 메뉴 상세 화면 구현
   - [x] 수량 조절 기능 구현

2. [x] 장바구니를 누르면 장바구니 화면으로 넘어가고 장바구니 메뉴 조정 및 취소 버튼도 구성해주고 결제 버튼까지 구현해주세요.

   - [x] 장바구니 모델 구현
   - [x] 장바구니 서비스 구현
   - [x] 장바구니 뷰모델 구현
   - [ ] 장바구니 UI 구현
   - [ ] 결제 버튼 구현

3. [ ] 결제 화면에서 결제 수단 선택 및 결제 처리 기능까지 구현해주세요.

4. [x] header부분 바로 밑에 검색 창을 만들어주세요.

5. [x] 특별 할인 이벤트와 지금 핫한 메뉴 UI 개선

   - [x] 특별 할인 이벤트 섹션: 자동으로 넘어가는 광고형 슬라이드 구현
   - [x] 지금 핫한 메뉴 섹션: 수직으로 수동으로 넘기는 슬라이드 구현
   - [x] 음식점 데이터 추가 (이름, 가격, 설명, 이미지)

6. [x] 구현했던거 오류 분석 후 수정
   - [x] Category 모델 icon 필드 추가
   - [x] HomeViewModel loadSpecialSections 호출 추가
   - [x] 필요한 import 추가

# 5차 수정

0. 한식(갈비찜), 디저트(탕후루), 피자(딸기피자)에서 이미지와 내용이 구현이 안된 부분이 있습니다.

1. 음식점 클릭 시 메뉴 담기 화면으로 넘어가고 상품 개수 조정 및 취소 버튼도 구성해주고 기능까지 구현해주세요. 그리고 음식에 맞는 사이드 추가도 구현해주면 좋아요.

- 메뉴 모델 구현
- 메뉴 서비스 구현
- 메뉴 상세 화면 구현
- 수량 조절 기능 구현

2. 장바구니를 누르면 장바구니 화면으로 넘어가고 장바구니 메뉴 조정 및 취소 버튼도 구성해주고 결제 버튼까지 구현해주세요.

   - 장바구니 모델 구현
   - 장바구니 서비스 구현
   - 장바구니 뷰모델 구현
   - 장바구니 UI 구현
   - 결제 버튼 구현

3. 결제 화면에서 결제 수단 선택 및 결제 처리 기능까지 구현해주세요.

# 6차 수정

1. [x] 음식들 가격 임의로 넣어주시고, 담기 누르면 장바구니에 담아지고, 장바구니에 담은 음식들 가격 계산 기능 구현해주세요.

2. [x] 담는 화면에서 해당 음식 사진이 보이게 해주세요.
