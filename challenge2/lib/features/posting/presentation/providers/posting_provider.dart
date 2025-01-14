import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostingProvider extends ChangeNotifier {
  String _content = '';
  XFile? _image;
  bool _isLoading = false;

  String get content => _content;
  XFile? get image => _image;
  bool get isLoading => _isLoading;
  bool get canPost => _content.isNotEmpty || _image != null;

  void updateContent(String value) {
    _content = value;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1080,
        maxHeight: 1080,
        imageQuality: 85,
      );
      if (image != null) {
        _image = image;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }

  Future<void> createPost() async {
    if (!canPost) return;

    _isLoading = true;
    notifyListeners();

    // 실제 API 호출을 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    // 포스팅 성공 후 상태 초기화
    _content = '';
    _image = null;
    _isLoading = false;
    notifyListeners();
  }
} 