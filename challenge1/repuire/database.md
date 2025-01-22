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

## Additional Rules

1. Security Rules

   - Read: All authenticated users
   - Write: Own data only
   - Delete: Own data only

2. Performance Optimization
   - Indexes: createdAt, likeCount
   - Pagination: 20 items per load
   - Caching: Profile images for 24 hours
