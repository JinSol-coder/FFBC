# Firestore 데이터베이스 구조

## 사용자 정보 (users 컬렉션)

- uid: Firebase Auth에서 제공하는 고유 ID
- email: 사용자 이메일 주소
- displayName: 사용자 표시 이름
- photoURL: 프로필 이미지 주소
- provider: 소셜 로그인 제공자 (google, apple)
- createdAt: 가입 시간
- updatedAt: 정보 수정 시간

## 게시글 정보 (posts 컬렉션)

- postId: 게시글 고유 ID
- authorId: 작성자 ID (users의 uid 참조)
- content: 게시글 내용
- mediaUrls: 첨부된 미디어 파일 주소 목록
- likes: 좋아요 개수
- comments: 댓글 개수
- createdAt: 작성 시간
- updatedAt: 수정 시간
- commentCount: 댓글 수 카운터
- lastCommentAt: 마지막 댓글 작성 시간
- lastCommentPreview: { // 최근 댓글 미리보기
  content: 댓글 내용
  authorName: 작성자 이름
  createdAt: 작성 시간
  }

## 댓글 정보 (comments 서브컬렉션)

- commentId: 댓글 고유 ID
- postId: 연결된 게시글 ID
- authorId: 댓글 작성자 ID
- content: 댓글 내용
- createdAt: 작성 시간
- updatedAt: 수정 시간
- authorProfile: {
  displayName: 작성자 표시 이름
  photoURL: 프로필 이미지 주소
  email: 이메일 주소
  }
- mediaUrls: 댓글 첨부 미디어 파일 주소 목록

### 댓글 작성 프로세스

1. 댓글 작성 시

   - comments 서브컬렉션에 댓글 데이터 저장
   - posts의 commentCount 증가
   - lastCommentAt, lastCommentPreview 업데이트
   - 작성자의 프로필 정보 자동 포함

2. 댓글 삭제 시
   - comments 서브컬렉션에서 댓글 삭제
   - posts의 commentCount 감소
   - 연관된 미디어 파일 자동 삭제
   - lastCommentPreview 업데이트 (이전 댓글 정보로)

### 댓글 미디어 관리

1. 저장 경로

   - 이미지: `/comments/{postId}/{commentId}/images/{filename}`
   - 동영상: `/comments/{postId}/{commentId}/videos/{filename}`
   - 썸네일: `/comments/{postId}/{commentId}/thumbnails/{filename}`

2. 파일 관리 규칙

   - 이미지 최대 크기: 5MB
   - 동영상 최대 크기: 20MB
   - 지원 포맷: jpg, png, mp4
   - 이미지 자동 리사이징: 1280x1280 최대
   - 썸네일 자동 생성: 200x200

3. 스토리지 트리거
   - 댓글 삭제 시 연관 미디어 자동 삭제
   - 미사용 파일 24시간 후 자동 정리
   - 업로드 실패 시 임시 파일 자동 삭제

### 보안 규칙

1. 댓글 읽기

   - 모든 인증된 사용자 허용
   - 게시글 작성자는 항상 허용

2. 댓글 쓰기

   - 인증된 사용자만 가능
   - 스팸 방지를 위한 작성 간격 제한 (1분)
   - 미디어 파일 크기 및 형식 검증

3. 댓글 수정/삭제
   - 작성자 본인만 가능
   - 게시글 작성자는 모든 댓글 삭제 가능
   - 관리자는 모든 권한 보유

# Firebase Storage 구조

## 저장소 규칙

### 프로필 이미지 저장소

- Path: `/profiles/{userId}/profile.{extension}`
- Size Limit: 5MB
- Allowed Formats: jpg, jpeg, png

### Post Media

- Path: `/posts/{userId}/{postId}/{filename}`
- Size Limit: Images 10MB, Videos 50MB
- Allowed Formats: jpg, jpeg, png, mp4, mov

### Comment Media

- Path: `/comments/{userId}/{commentId}/{filename}`
- Size Limit: Images 5MB, Videos 20MB
- Allowed Formats: jpg, jpeg, png, mp4, mov

## Data Management Guidelines

1. User Data Management

   - Auto-save user info to users collection on social login
   - Profile updates restricted to authenticated users
   - Delete all related data on account deletion

2. Post Data Management

   - Save post data to posts collection
   - Upload media files to storage before saving URLs
   - Modifications/deletions restricted to author only

3. Media File Management
   - Generate UUID for filenames to prevent duplicates
   - Regular cleanup of unused files
   - Auto-delete temporary files after 24 hours
   - 댓글 미디어 파일은 댓글 삭제 시 자동 삭제
   - 댓글 작성자 프로필 정보 변경 시 연관 댓글 정보 자동 업데이트

## Additional Rules

1. Security Rules

   - Read: All authenticated users
   - Write: Own data only
   - Delete: Own data only

2. Performance Optimization
   - Indexes: createdAt, likeCount
   - Pagination: 20 items per load
   - Caching: Profile images for 24 hours

# 구현 계획 체크리스트

## 1. 인증 및 사용자 관리

- [x] 소셜 로그인 구현
  - [x] Google 로그인 연동
  - [x] Apple 로그인 연동
- [x] 로그인 성공 시 users 컬렉션에 사용자 정보 저장
  - [x] 신규 사용자 생성
  - [x] 기존 사용자 정보 업데이트
- [x] 프로필 관리 기능
  - [x] 프로필 이미지 업로드/수정
  - [x] 사용자 정보 수정

## 2. 게시글 관리

- [x] 게시글 CRUD 구현
  - [x] 게시글 작성 (텍스트)
  - [x] 게시글 작성 시 미디어 파일 업로드
  - [x] 게시글 수정
  - [x] 게시글 삭제 (연관 미디어 파일 포함)
- [x] 게시글 조회 기능
  - [x] 전체 게시글 목록 페이지네이션
  - [x] 특정 사용자의 게시글 필터링

## 3. 미디어 파일 관리

- [x] Storage 업로드 구현
  - [x] 프로필 이미지 업로드
  - [x] 게시글 미디어 파일 업로드
  - [x] 파일 용량 및 형식 검증
- [x] 파일 관리 기능
  - [x] UUID 기반 파일명 생성
  - [ ] 미사용 파일 정리 로직
  - [ ] 임시 파일 자동 삭제

## 4. 상호작용 기능

- [x] 좋아요 기능
  - [x] 좋아요 토글
  - [x] 좋아요 수 실시간 업데이트
- [x] 댓글 기능
  - [x] 댓글 작성
  - [x] 댓글 수정/삭제
  - [x] 댓글 목록 조회
  - [x] 댓글 미디어 파일 업로드
  - [x] 댓글 작성자 프로필 정보 실시간 동기화
  - [ ] 댓글 알림 기능

## 7. 댓글 시스템 구현 순서

### 7.1 기본 댓글 기능 구현

1. 기본 UI 구현

   - [x] 댓글 입력 폼 개발
   - [x] 댓글 목록 표시 컴포넌트
   - [x] 댓글 작성/수정/삭제 버튼
   - [x] 댓글 작성 중 미리보기

2. Firestore 기본 연동
   - [x] comments 서브컬렉션 설계 및 초기화
   - [x] 댓글 작성 기능 구현
   - [x] 댓글 수정 기능 구현
   - [x] 댓글 삭제 기능 구현
   - [x] 댓글 목록 조회 구현

### 7.2 프로필 연동

1. 프로필 정보 통합

   - [x] 댓글 작성 시 현재 로그인 사용자 정보 연동
   - [x] 프로필 이미지와 이름 표시
   - [ ] 작성자 프로필 클릭 시 상세정보 표시

2. 실시간 동기화
   - [x] 프로필 정보 변경 감지 리스너 설정
   - [ ] 프로필 업데이트 시 관련 댓글 자동 갱신

### 7.3 미디어 기능

1. 미디어 업로드

   - [x] 이미지/비디오 선택 버튼 추가
   - [x] Storage 업로드 로직 구현
   - [x] 업로드 진행률 UI 구현
   - [x] 미디어 파일 미리보기

2. 미디어 처리
   - [x] 파일 크기/형식 검증
   - [ ] 이미지 압축 및 리사이징
   - [ ] 썸네일 자동 생성
   - [x] 업로드 실패 시 재시도 로직

### 7.4 보안 및 최적화

1. 보안 설정

   - [ ] Firestore 댓글 접근 규칙 설정
   - [ ] Storage 미디어 파일 접근 규칙
   - [ ] 사용자 권한 검증 로직

2. 성능 개선
   - [ ] 댓글 페이지네이션 (15개씩)
   - [ ] 댓글 데이터 캐싱
   - [ ] 이미지 로딩 최적화
   - [ ] 실시간 업데이트 효율화

### 7.5 마무리

1. 추가 기능

   - [ ] 댓글 정렬 (최신순/인기순)
   - [ ] 새 댓글 알림
   - [ ] 댓글 좋아요 기능
   - [ ] 답글 기능

2. 안정화
   - [ ] 에러 처리 보완
   - [ ] 사용자 피드백 개선
   - [ ] 성능 테스트 및 최적화
   - [ ] 코드 정리 및 문서화

## 5. 보안 및 규칙 설정

- [x] Firestore 보안 규칙 설정
  - [x] 읽기/쓰기 권한 설정
  - [x] 사용자 인증 확인
- [x] Storage 보안 규칙 설정
  - [x] 파일 업로드 권한
  - [x] 파일 접근 권한

## 6. 성능 최적화

- [x] 인덱스 설정
  - [x] createdAt 인덱스
  - [x] likes 인덱스
- [ ] 캐싱 구현
  - [ ] 프로필 이미지 캐싱
  - [ ] 게시글 데이터 캐싱
- [ ] 앱 시작 최적화
  - [ ] Firebase 지연 초기화
  - [ ] 필수 서비스만 우선 초기화
