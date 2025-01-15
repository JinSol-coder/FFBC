import 'package:flutter/material.dart';

import '../../data/models/post_model.dart';
import '../../data/services/mock_data_service.dart';

class HomeProvider extends ChangeNotifier {
  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  bool _hasMore = true;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;
  bool get hasMore => _hasMore;

  void addNewPost(PostModel post) {
    _posts.insert(0, post);
    notifyListeners();
  }

  Future<void> refresh() async {
    _isRefreshing = true;
    notifyListeners();

    // 실제 API 호출을 시뮬레이션
    await Future.delayed(const Duration(seconds: 2));
    
    // 기존 게시글들을 유지하면서 새로운 게시글 추가
    final newPosts = MockDataService.generatePosts();
    final existingPosts = _posts;  // 기존 게시글 보존
    _posts = [...existingPosts, ...newPosts];  // 기존 게시글 뒤에 새 게시글 추가
    _hasMore = true;
    _isRefreshing = false;
    
    notifyListeners();
  }

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
