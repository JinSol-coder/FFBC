# project overview (프로젝트 요약)
배민 스타일 배달 앱 ui를 제작하려고 합니다. 
앱 이름 : 맘마굿
흰색 배경에 주황 글씨로 제작. 

# Core functionalities(핵심 기능)
홈 화면 : 상단는 음식 카테고리별 버튼을 설정이 있고 하단에는 메뉴 추천 섹션 디자인
음식 선택시 "담기" 화면 구현
담기 버튼 클릭시 장바구니(담기, 구매) 알람창 표시
장바구니를 누르면 하단에 결제 버튼 표시, 누르고 임의로 간단한 결제 페이지 추가

# Doc (참고 문서)
- Flutter 공식 문서: https://docs.flutter.dev/
- Material Design 가이드: https://m3.material.io/
- GetX 상태관리 문서: https://pub.dev/packages/get
- Flutter 네비게이션 2.0: https://docs.flutter.dev/development/ui/navigation

# Current file structure (현재 파일 구조)
lib/
├── main.dart
├── app/
│   ├── bindings/
│   ├── controllers/
│   ├── data/
│   │   ├── models/
│   │   ├── providers/
│   │   └── repositories/
│   ├── modules/
│   │   ├── home/
│   │   ├── cart/
│   │   ├── menu/
│   │   └── payment/
│   ├── routes/
│   └── themes/
├── assets/
│   ├── images/
│   └── icons/
└── test/