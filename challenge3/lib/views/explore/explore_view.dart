import 'package:flutter/cupertino.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('둘러보기'),
      ),
      child: SafeArea(
        child: Center(
          child: Text('둘러보기 화면'),
        ),
      ),
    );
  }
} 