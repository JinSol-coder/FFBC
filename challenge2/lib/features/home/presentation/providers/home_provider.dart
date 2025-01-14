import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';
import '../../data/services/mock_data_service.dart';

class HomeProvider extends ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadInitialPosts() async {
    if (_posts.isNotEmpty) return;
    
    _isLoading = true;
    notifyListeners();

    // 실제 API 호출을 시뮬레이션하기 위한 지연
    await Future.delayed(const Duration(seconds: 1));
    _posts = MockDataService.generatePosts();
    
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMorePosts() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    final newPosts = MockDataService.generatePosts();
    
    _posts.addAll(newPosts);
    _hasMore = newPosts.isNotEmpty;
    _isLoading = false;
    
    notifyListeners();
  }
} 