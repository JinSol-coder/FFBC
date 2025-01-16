# Frontend 개발 명세서

## 현재 진행 상황
1. ✅ 프로젝트 기본 설정
   - 의존성 추가 (provider, youtube_player_flutter)
   - 기본 앱 구조 설정 (main.dart, app.dart)
   - 기본 상수 정의 (colors, typography)
   - 기본 모델 클래스 생성 (Track, Playlist)

2. ✅ 홈 화면 구현
   - HomeViewModel 구현 (플레이리스트 및 현재 트랙 관리)
   - HomeView 구현 (CupertinoPageScaffold 기반)
   - PlaylistCard 위젯 구현 (Image.network 사용)
   - MiniPlayer 위젯 구현

3. ✅ 플레이어 화면 구현
   - PlayerViewModel 구현 (재생 상태 및 진행 상태 관리)
   - PlayerView 구현 (앨범 아트, 트랙 정보 표시)
   - PlayerControls 위젯 구현 (재생/일시정지, 이전/다음 트랙, 셔플/반복)
   - ProgressSlider 위젯 구현 (재생 진행률 표시 및 조절)

4. ✅ 네비게이션 구현
   - CupertinoTabScaffold를 사용한 하단 탭 바 구현
   - 홈, 샘플, 둘러보기, 보관함 탭 구현
   - 각 탭의 기본 화면 구조 구현

5. ✅ 부가 기능 구현
   - YouTube 재생 기능 구현 (YoutubePlayerService)
   - PlayerViewModel과 YouTube 플레이어 연동
   - 재생 상태 및 진행률 실시간 업데이트
   - 재생/일시정지, 탐색 기능 구현

## 현재 파일 구조

lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   └── app_typography.dart
│   └── utils/
│       └── duration_formatter.dart
├── models/
│   ├── playlist.dart
│   ├── track.dart
│   └── artist.dart
├── services/
│   └── youtube_player_service.dart
├── views/
│   ├── home/
│   │   ├── home_view.dart
│   │   └── widgets/
│   │       ├── playlist_card.dart
│   │       └── mini_player.dart
│   ├── player/
│   │   ├── player_view.dart
│   │   └── widgets/
│   │       ├── player_controls.dart
│   │       └── progress_slider.dart
│   ├── explore/
│   │   └── explore_view.dart
│   ├── library/
│   │   └── library_view.dart
│   └── sample/
│       └── sample_view.dart
└── viewmodels/
    ├── home_viewmodel.dart
    └── player_viewmodel.dart

## 기술 스택
- Flutter 3.x
- Provider (상태 관리)
- youtube_player_flutter (YouTube 재생)

## 주요 위젯 활용
- CupertinoTabScaffold
- CupertinoTabBar
- CupertinoNavigationBar
- CupertinoPageScaffold
- CupertinoSlider
- CupertinoListSection
- CupertinoSearchTextField
- CupertinoScrollbar

## 구현 기능

### 홈 화면
- 인기/추천 플레이리스트 표시
- 장르별 음악 분류 (운동, 에너지 충전, 팟캐스트 등)
- 하단 미니 플레이어
- CupertinoScrollbar 적용된 스크롤 뷰

### 음악 재생 화면
- YouTube URL 기반 음악 재생
- 앨범 아트 및 아티스트 정보 표시
- 재생 컨트롤 (재생/일시정지, 다음/이전 트랙)
- CupertinoSlider 기반 진행 바
- 좋아요, 반복, 셔플 기능

### 네비게이션
- CupertinoTabBar 기반 하단 탭 네비게이션
- 홈, 샘플, 둘러보기, 보관함 메뉴
- iOS 스타일 아이콘 및 강조 효과

### 플레이리스트 상세 화면
- 플레이리스트 헤더 (표지, 제목, 설명)
- 전체 재생 버튼
- 트랙 리스트 (썸네일, 제목, 아티스트)
- 트랙 선택 시 재생
- 트랙별 더보기 메뉴

## 참고사항
- 모든 UI는 iOS 스타일 준수
- MVVM 패턴으로 구현
- Provider를 활용한 상태 관리
- 재사용 가능한 위젯 컴포넌트화
