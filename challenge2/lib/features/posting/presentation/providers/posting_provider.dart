import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../home/data/models/post_model.dart';
import '../../../home/data/models/user_model.dart';
import '../../../home/presentation/providers/home_provider.dart';

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

  Future<void> createPost(BuildContext context) async {
    if (!canPost) return;

    _isLoading = true;
    notifyListeners();

    // 이미지 업로드 시뮬레이션
    String? imageUrl;
    if (_image != null) {
      await Future.delayed(const Duration(seconds: 1));
      imageUrl =
          'https://picsum.photos/500/300?random=${DateTime.now().millisecondsSinceEpoch}';
    }

    // 새 게시글 생성
    final newPost = PostModel(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      user: const UserModel(
        id: 'current_user',
        username: 'current_user',
        displayName: '사용자 닉네임',
        profileImage: 'https://picsum.photos/200',
        isVerified: true,
      ),
      content: _content,
      images: imageUrl != null ? [imageUrl] : null,
      createdAt: DateTime.now(),
      likesCount: 0,
      repliesCount: 0,
    );

    // HomeProvider를 통해 새 게시글 추가
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.addNewPost(newPost);

    // 상태 초기화
    _content = '';
    _image = null;
    _isLoading = false;
    notifyListeners();
  }
}
