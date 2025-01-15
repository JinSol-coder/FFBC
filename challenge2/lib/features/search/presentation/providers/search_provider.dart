import 'package:flutter/material.dart';

import '../../../home/data/models/user_model.dart';

class SearchProvider extends ChangeNotifier {
  String _query = '';
  bool _isLoading = false;
  bool _hasMore = true;
  List<UserModel> _searchResults = [];

  String get query => _query;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  List<UserModel> get searchResults => _searchResults;

  Future<void> search(String query) async {
    if (_query == query) return;

    _query = query;
    _isLoading = true;
    notifyListeners();

    if (query.isEmpty) {
      _searchResults = [];
      _isLoading = false;
      notifyListeners();
      return;
    }

    // 검색 API 호출 시뮬레이션
    await Future.delayed(const Duration(milliseconds: 500));

    // 더미 검색 결과 생성
    _searchResults = List.generate(
      20,
      (index) => UserModel(
        id: 'user_$index',
        username: 'user$index',
        displayName: '사용자 $index',
        profileImage: 'https://picsum.photos/200?random=$index',
        isVerified: index % 5 == 0,
      ),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore || _query.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    // 추가 결과 로딩 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    final newResults = List.generate(
      10,
      (index) => UserModel(
        id: 'user_${_searchResults.length + index}',
        username: 'user${_searchResults.length + index}',
        displayName: '사용자 ${_searchResults.length + index}',
        profileImage:
            'https://picsum.photos/200?random=${_searchResults.length + index}',
        isVerified: index % 5 == 0,
      ),
    );

    _searchResults.addAll(newResults);
    _hasMore = newResults.isNotEmpty;
    _isLoading = false;
    notifyListeners();
  }
}
