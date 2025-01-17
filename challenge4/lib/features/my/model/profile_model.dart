class ProfileModel {
  String name;
  String? imageUrl;
  bool pushNotification;
  bool emailNotification;
  String theme;
  String language;

  ProfileModel({
    required this.name,
    this.imageUrl,
    this.pushNotification = true,
    this.emailNotification = false,
    this.theme = 'system',
    this.language = 'ko',
  });
} 