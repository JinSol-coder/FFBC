import 'package:flutter/cupertino.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        border: null,
        middle: const Text(
          '보관함',
          style: TextStyle(color: CupertinoColors.white),
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text(
            '보관함 페이지',
            style: TextStyle(color: CupertinoColors.white),
          ),
        ),
      ),
    );
  }
} 