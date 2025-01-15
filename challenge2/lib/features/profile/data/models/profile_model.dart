import '../../../home/data/models/user_model.dart';

class ProfileModel {
  final UserModel user;
  final String? bio;
  final int postsCount;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;
  final bool isCurrentUser;

  const ProfileModel({
    required this.user,
    this.bio,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
    this.isFollowing = false,
    this.isCurrentUser = false,
  });
}
