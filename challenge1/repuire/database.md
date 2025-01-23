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
  - [ ] 댓글 미디어 파일 업로드
  - [ ] 댓글 작성자 프로필 정보 실시간 동기화
  - [ ] 댓글 알림 기능

## 7. 댓글 시스템 구현 계획

### 7.1 댓글 기본 기능

- [ ] 댓글 작성 UI 구현
  - [ ] 댓글 입력 폼 개발
  - [ ] 미디어 파일 첨부 버튼 추가
  - [ ] 댓글 작성 중 프리뷰 기능
- [ ] Firestore 댓글 데이터 처리
  - [ ] comments 서브컬렉션 CRUD 구현
  - [ ] 댓글 작성 시 작성자 프로필 정보 자동 저장
  - [ ] 댓글 수 실시간 업데이트
  - [ ] 페이지네이션 구현 (10개씩 로드)

### 7.2 댓글 미디어 관리

- [ ] Storage 업로드 기능
  - [ ] 이미지/비디오 파일 선택 기능
  - [ ] 파일 크기 및 형식 검증
  - [ ] 업로드 진행률 표시
  - [ ] 임시 저장소 관리
- [ ] 미디어 파일 처리
  - [ ] UUID 기반 파일명 생성
  - [ ] 썸네일 생성 (이미지/비디오)
  - [ ] 미디어 파일 최적화
  - [ ] 실패한 업로드 자동 정리

### 7.3 실시간 동기화

- [ ] 프로필 정보 연동
  - [ ] 작성자 프로필 변경 감지
  - [ ] 연관 댓글 프로필 정보 자동 업데이트
  - [ ] 프로필 이미지 캐싱
- [ ] 실시간 업데이트
  - [ ] 새 댓글 알림
  - [ ] 댓글 수정/삭제 실시간 반영
  - [ ] 댓글 정렬 (최신순/인기순)

### 7.4 보안 및 권한 관리

- [ ] Firestore 규칙 설정
  - [ ] 댓글 읽기/쓰기 권한 설정
  - [ ] 수정/삭제 권한 검증
  - [ ] 스팸 방지 규칙
- [ ] Storage 규칙 설정
  - [ ] 미디어 파일 업로드 권한
  - [ ] 파일 접근 제어
  - [ ] 용량 제한 설정

### 7.5 성능 최적화

- [ ] 데이터 최적화
  - [ ] 댓글 인덱스 설정
  - [ ] 쿼리 최적화
  - [ ] 캐싱 전략 수립
- [ ] 미디어 최적화
  - [ ] 이미지 압축
  - [ ] 비디오 트랜스코딩
  - [ ] CDN 활용 계획

### 7.6 에러 처리

- [ ] 예외 처리
  - [ ] 네트워크 오류 처리
  - [ ] 업로드 실패 처리
  - [ ] 권한 오류 처리
- [ ] 복구 메커니즘
  - [ ] 실패한 업로드 재시도
  - [ ] 임시 데이터 복구
  - [ ] 동기화 오류 해결

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
