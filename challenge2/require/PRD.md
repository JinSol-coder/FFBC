# Project overview

1. '쓰레드' 스타일의 SNS 앱 (UI만 디자인)
2. 간단한 포스팅 기능만 구현
3. 블랙 위주의 심플한 디자인

# Core functionalities

1. 사용자는 홈 피드에서 다른 사람의 게시글을 볼 수 있다.
   (개발 환경에서는 더미로 다른 사용자의 게시글을 생성)
2. 홈 피드에서는 스크롤을 통해 게시글을 볼 수 있으며,
   스크롤을 아래로 내리면서 새로운 게시글이 로딩된다.
3. 하단 네비게이션 바는 홈, 검색, 포스팅, 활동, 프로필 탭으로 구성된다.
4. 포스팅 탭에서는 새로운 게시글을 작성할 수 있으며,
   이미지 촬영 및 업로드 기능이 포함되어 있다.

# Doc

## Required Packages

1. **상태 관리**

   - provider: ^6.0.0 (상태 관리)
   - get_it: ^7.6.0 (의존성 주입)

2. **UI/디자인**

   - google_fonts: ^5.1.0 (폰트 관리)
   - flutter_svg: ^2.0.7 (SVG 아이콘)
   - cached_network_image: ^3.2.3 (이미지 캐싱)

3. **이미지 관련**

   - image_picker: ^1.0.4 (이미지 선택/촬영)
   - photo_view: ^0.14.0 (이미지 상세보기)

4. **네비게이션**

   - go_router: ^10.1.2 (라우팅)

5. **기타 유틸리티**
   - intl: ^0.18.1 (다국어/날짜 포맷)
   - shimmer: ^3.0.0 (로딩 효과)

## Development Environment

- Flutter SDK: 3.13.0 이상
- Dart SDK: 3.1.0 이상
- Android Studio / VS Code
- Android SDK version: 33 (minimum 21)
- iOS Deployment Target: 12.0

# Implementation Checklist

## 1. 프로젝트 설정

- [x] 프로젝트 구조 설계
- [x] 필요한 패키지 추가 (pubspec.yaml 수정)
- [x] 테마 설정 (다크 테마 중심)
- [x] 라우팅 설정 (go_router)

## 2. 기본 구조 구현

- [x] 네비게이션 바 구현
- [x] 기본 페이지 구조 설정 (5개 탭)
- [x] 상태 관리 설정 (Provider)
- [x] 더미 데이터 모델 생성

## 3. 주요 기능 구현

- [x] 홈 피드 UI 구현
- [x] 무한 스크롤 기능 구현
- [x] 포스팅 페이지 UI 구현
- [x] 이미지 선택/촬영 기능 구현
- [x] 검색 페이지 UI 구현
- [x] 활동 페이지 UI 구현
- [x] 프로필 페이지 UI 구현

## 4. 마무리

- [ ] 성능 최적화
- [ ] 코드 리팩토링
- [ ] 테스트 작성
- [ ] 문서화

# Current file structure (현재 파일 구조)

해당 프로젝트에 맞는 파일구조를 설계하고 작성
