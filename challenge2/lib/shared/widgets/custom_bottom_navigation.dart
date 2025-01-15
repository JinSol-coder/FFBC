import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.secondary,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_outlined),
          label: '포스팅',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: '활동',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: '프로필',
        ),
      ],
    );
  }
}
