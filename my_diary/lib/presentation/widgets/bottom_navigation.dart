import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigation extends StatelessWidget {
  final RxInt currentIndex = 0.obs;

  void _changePage(int index) {
    currentIndex.value = index;
    switch (index) {
      case 0:
        Get.offNamed('/home');
        break;
      case 1:
        Get.offNamed('/search');
        break;
      case 2:
        Get.offNamed('/create');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;
    if (currentRoute == '/home') currentIndex.value = 0;
    else if (currentRoute == '/search') currentIndex.value = 1;
    else if (currentRoute == '/create') currentIndex.value = 2;

    return Obx(() => BottomNavigationBar(
      currentIndex: currentIndex.value,
      onTap: _changePage,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.create),
          label: '작성',
        ),
      ],
    ));
  }
} 