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
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper),
            label: '뉴스',
          ),
          NavigationDestination(
            icon: Icon(Icons.trending_up),
            label: '추천',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'MY',
          ),
        ],
      ),
    );
  }
} 