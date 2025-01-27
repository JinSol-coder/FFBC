import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_navigation.dart';
import 'home_page.dart';
import 'search_page.dart';
import 'memo_editor_page.dart';

class MainPage extends GetView {
  final RxInt currentIndex = 0.obs;
  final pages = [
    HomePage(),
    SearchPage(),
    MemoEditorPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: currentIndex.value,
        children: pages,
      )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: currentIndex.value,
        onTap: (index) => currentIndex.value = index,
        selectedItemColor: Colors.blue,  // 선택된 탭 색상
        unselectedItemColor: Colors.grey,  // 선택되지 않은 탭 색상
        type: BottomNavigationBarType.fixed,  // 탭 애니메이션 타입
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
      )),
    );
  }
} 