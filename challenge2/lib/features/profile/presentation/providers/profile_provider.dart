import 'package:flutter/material.dart';
import '../../data/models/profile_model.dart';
import '../../../home/data/models/user_model.dart';
import '../../../home/data/models/post_model.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileModel? _profile;
  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;

  ProfileModel? get profile => _profile;
  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadProfile() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    // 프로필 데이터 로딩 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    _profile = ProfileModel(
      user: const UserModel(
        id: 'current_user',
        username: 'current_user',
        displayName: '현재 사용자',
        profileImage: 'https://picsum.photos/200',
        isVerified: true,
      ),
      bio: '쓰레드 클론 앱 개발 중입니다. Flutter와 Dart를 사용하고 있어요!',
      postsCount: 42,
      followersCount: 1234,
      followingCount: 567,
      isCurrentUser: true,
    );

    await loadPosts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadPosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final newPosts = List.generate(
      10,
      (index) => PostModel(
        id: 'post_${_posts.length + index}',
        user: _profile!.user,
        content: '프로필 게시글 #${_posts.length + index + 1}\n개발 일지를 공유합니다.',
        createdAt: DateTime.now().subtract(Duration(days: index)),
        likesCount: (index + 1) * 10,
        repliesCount: (index + 1) * 2,
        images: index % 2 == 0
            ? ['https://picsum.photos/500/300?random=${_posts.length + index}']
            : null,
      ),
    );

    _posts.addAll(newPosts);
    _hasMore = newPosts.isNotEmpty;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFollow() async {
    if (_profile == null || _profile!.isCurrentUser) return;

    await Future.delayed(const Duration(milliseconds: 500));

    _profile = ProfileModel(
      user: _profile!.user,
      bio: _profile!.bio,
      postsCount: _profile!.postsCount,
      followersCount:
          _profile!.followersCount + (_profile!.isFollowing ? -1 : 1),
      followingCount: _profile!.followingCount,
      isFollowing: !_profile!.isFollowing,
      isCurrentUser: _profile!.isCurrentUser,
    );

    notifyListeners();
  }
}
