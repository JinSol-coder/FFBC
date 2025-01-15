import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../shared/providers/app_state_provider.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/posting/presentation/pages/posting_page.dart';
import '../../features/activity/presentation/pages/activity_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../shared/widgets/custom_bottom_navigation.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRoutes {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/search',
            builder: (context, state) => const SearchPage(),
          ),
          GoRoute(
            path: '/posting',
            builder: (context, state) => const PostingPage(),
          ),
          GoRoute(
            path: '/activity',
            builder: (context, state) => const ActivityPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
  );
}

class ScaffoldWithBottomNavBar extends StatelessWidget {
  const ScaffoldWithBottomNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    return Scaffold(
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setIndex(index);
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              context.go('/search');
              break;
            case 2:
              context.go('/posting');
              break;
            case 3:
              context.go('/activity');
              break;
            case 4:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
