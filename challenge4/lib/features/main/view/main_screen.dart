import 'package:flutter/material.dart';
import '../../home/view/home_screen.dart';
import '../../news/view/news_screen.dart';
import '../../recommend/view/recommend_screen.dart';
import '../../my/view/my_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    NewsScreen(),
    RecommendScreen(),
    MyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        indicatorColor: Colors.blue.withOpacity(0.1),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home, color: _currentIndex == 0 ? Colors.blue : null),
            label: '홈',
            selectedIcon: Icon(Icons.home, color: Colors.blue),
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper, color: _currentIndex == 1 ? Colors.blue : null),
            label: '뉴스',
            selectedIcon: Icon(Icons.newspaper, color: Colors.blue),
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up, color: _currentIndex == 2 ? Colors.blue : null),
            label: '추천',
            selectedIcon: Icon(Icons.trending_up, color: Colors.blue),
          ),
          NavigationDestination(
            icon: Icon(Icons.person, color: _currentIndex == 3 ? Colors.blue : null),
            label: 'MY',
            selectedIcon: Icon(Icons.person, color: Colors.blue),
          ),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      ),
    );
  }
} 