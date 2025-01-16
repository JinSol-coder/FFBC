import 'package:flutter/cupertino.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: const Text(
          '둘러보기',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text(
            '둘러보기 페이지',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      ),
    );
  }
} 