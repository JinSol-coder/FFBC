class UserModel {
  final String id;
  final String username;
  final String displayName;
  final String? profileImage;
  final bool isVerified;

  const UserModel({
    required this.id,
    required this.username,
    required this.displayName,
    this.profileImage,
    this.isVerified = false,
  });
} 