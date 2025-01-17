import 'package:flutter/foundation.dart';
import '../model/profile_model.dart';

class MyViewModel extends ChangeNotifier {
  ProfileModel _profile = ProfileModel(name: '사용자');

  ProfileModel get profile => _profile;

  void updateName(String newName) {
    _profile.name = newName;
    notifyListeners();
  }

  void togglePushNotification(bool value) {
    _profile.pushNotification = value;
    notifyListeners();
  }

  void toggleEmailNotification(bool value) {
    _profile.emailNotification = value;
    notifyListeners();
  }

  void updateTheme(String theme) {
    _profile.theme = theme;
    notifyListeners();
  }

  void updateLanguage(String language) {
    _profile.language = language;
    notifyListeners();
  }
} 