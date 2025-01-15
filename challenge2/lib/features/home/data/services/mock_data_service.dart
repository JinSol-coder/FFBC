import '../models/post_model.dart';
import '../models/user_model.dart';

class MockDataService {
  static final List<UserModel> _users = [
    const UserModel(
      id: '1',
      username: 'elonmusk',
      displayName: 'Elon Musk',
      isVerified: true,
      profileImage: 'https://picsum.photos/200',
    ),
    const UserModel(
      id: '2',
      username: 'markzuckerberg',
      displayName: 'Mark Zuckerberg',
      isVerified: true,
      profileImage: 'https://picsum.photos/201',
    ),
    const UserModel(
      id: '3',
      username: 'sundarpichai',
      displayName: 'Sundar Pichai',
      isVerified: true,
      profileImage: 'https://picsum.photos/202',
    ),
  ];

  static List<PostModel> generatePosts() {
    return List.generate(
      20,
      (index) => PostModel(
        id: 'post_$index',
        user: _users[index % _users.length],
        content: '이것은 테스트 게시글 #${index + 1}입니다. 쓰레드 스타일의 SNS 앱을 만들고 있어요!',
        createdAt: DateTime.now().subtract(Duration(hours: index)),
        likesCount: index * 10,
        repliesCount: index * 5,
        images: index % 2 == 0
            ? ['https://picsum.photos/500/300?random=$index']
            : null,
      ),
    );
  }
}
