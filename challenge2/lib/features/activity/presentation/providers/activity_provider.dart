import 'package:flutter/material.dart';
import '../../data/models/activity_model.dart';
import '../../../home/data/models/user_model.dart';

class ActivityProvider extends ChangeNotifier {
  List<ActivityModel> _activities = [];
  bool _isLoading = false;
  bool _hasMore = true;

  List<ActivityModel> get activities => _activities;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> loadActivities() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    // 활동 데이터 로딩 시뮬레이션
    await Future.delayed(const Duration(seconds: 1));

    _activities = List.generate(
      20,
      (index) => ActivityModel(
        id: 'activity_$index',
        user: UserModel(
          id: 'user_$index',
          username: 'user$index',
          displayName: '사용자 $index',
          profileImage: 'https://picsum.photos/200?random=$index',
          isVerified: index % 5 == 0,
        ),
        type: ActivityType.values[index % ActivityType.values.length],
        content: index % 2 == 0 ? '이것은 테스트 답글입니다 #${index + 1}' : null,
        createdAt: DateTime.now().subtract(Duration(hours: index)),
        isRead: index > 10,
      ),
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final newActivities = List.generate(
      10,
      (index) {
        final newIndex = _activities.length + index;
        return ActivityModel(
          id: 'activity_$newIndex',
          user: UserModel(
            id: 'user_$newIndex',
            username: 'user$newIndex',
            displayName: '사용자 $newIndex',
            profileImage: 'https://picsum.photos/200?random=$newIndex',
            isVerified: newIndex % 5 == 0,
          ),
          type: ActivityType.values[newIndex % ActivityType.values.length],
          content: newIndex % 2 == 0 ? '이것은 테스트 답글입니다 #${newIndex + 1}' : null,
          createdAt: DateTime.now().subtract(Duration(hours: newIndex)),
          isRead: false,
        );
      },
    );

    _activities.addAll(newActivities);
    _hasMore = newActivities.isNotEmpty;
    _isLoading = false;
    notifyListeners();
  }
} 