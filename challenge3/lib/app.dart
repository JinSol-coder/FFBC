import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:challenge3/views/home/home_view.dart';
import 'package:challenge3/views/explore/explore_view.dart';
import 'package:challenge3/views/library/library_view.dart';
import 'package:challenge3/viewmodels/home_viewmodel.dart';
import 'package:challenge3/viewmodels/player_viewmodel.dart';
import 'package:challenge3/core/constants/app_colors.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => PlayerViewModel()),
      ],
      child: CupertinoApp(
        title: 'Music Player',
        theme: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.activeOrange,
        ),
        home: const AppScaffold(),
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.black,
      tabBar: CupertinoTabBar(
        backgroundColor: CupertinoColors.black,
        activeColor: CupertinoColors.activeOrange,
        inactiveColor: CupertinoColors.systemGrey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.compass_fill),
            label: '둘러보기',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.collections_solid),
            label: '보관함',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomeView();
              case 1:
                return const ExploreView();
              case 2:
                return const LibraryView();
              default:
                return const HomeView();
            }
          },
        );
      },
    );
  }
} 