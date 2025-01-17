#project-overview (프로젝트 개요)
- MVVM 아키텍처를 사용한 뉴스 피드 애플리케이션
- Unsplash API를 활용한 이미지 통합
- 직관적인 UI/UX를 제공하는 멀티탭 인터페이스

#feature-requirements (기능 요구사항)

## 1. 홈 피드 기능
- 섹션별 뉴스 콘텐츠 표시
- Unsplash API 이미지 통합
- 무한 스크롤 구현
- 새로고침 기능

## 2. 검색 기능
- 상단 검색바 구현
- 검색어 자동완성
- 검색 히스토리 관리
- 검색 결과 필터링

## 3. 탭 메뉴 기능
- 뉴스/날씨/MY 탭 네비게이션
- 탭별 독립적 상태 관리
- 탭 전환 애니메이션

#relevant-codes (관련 코드)
## API 연동
- Unsplash API 통신 로직
- 더미 데이터 생성 로직
- HTTP 요청 처리

## 상태 관리
- Provider 또는 Riverpod 사용
- 각 화면별 ViewModel 구현
- 데이터 캐싱 처리

#Current-file-instruction (현재 파일 구조)

lib/
├── main.dart
├── app/
│ └── app.dart
├── core/
│ ├── constants/
│ ├── theme/
│ └── utils/
├── features/
│ ├── home/
│ │ ├── view/
│ │ │ └── home_screen.dart
│ │ ├── viewmodel/
│ │ │ └── home_viewmodel.dart
│ │ └── model/
│ │ └── news_model.dart
│ ├── search/
│ │ ├── view/
│ │ ├── viewmodel/
│ │ └── model/
│ └── profile/
│ ├── view/
│ ├── viewmodel/
│ └── model/
├── shared/
│ ├── widgets/
│ └── services/
└── data/
├── repositories/
├── datasources/
└── api/

#rules (규칙)

# rules (규칙)

## 1. 코드 구조 규칙
- MVVM 패턴 준수
- 각 기능별 독립적인 모듈화
- 재사용 가능한 컴포넌트 분리

## 2. 작업 순서
1. 프로젝트 초기 설정 ✅
   - 프로젝트 생성 및 기본 구조 설정 ✅
   - 필요한 패키지 추가 ✅
   - 테마 및 상수 설정 ✅

2. 기본 인프라 구축 ✅
   - API 서비스 레이어 구현 ✅
   - 기본 네비게이션 설정 ✅
   - 공통 위젯 개발 ✅

3. 홈 피드 개발 ✅
   - 피드 UI 구현 ✅
   - Unsplash API 연동 ✅
   - 무한 스크롤 구현 ✅

4. 검색 기능 개발 ✅
   - 검색 UI 구현 ✅
   - 검색 로직 구현 ✅
   - 검색 결과 표시 ✅

5. 탭 메뉴 개발 ✅
   - 탭 네비게이션 구현 ✅
   - 각 탭 화면 개발 ✅
   - 탭간 상태 관리 ✅

6. 테스트 및 최적화 ✅
   - 단위 테스트 작성 ✅
   - UI 테스트 ✅
   - 성능 최적화 ✅

## 3. 코딩 컨벤션
- 파일명: snake_case 사용
- 클래스명: PascalCase 사용
- 변수/함수명: camelCase 사용
- 상수: UPPER_SNAKE_CASE 사용