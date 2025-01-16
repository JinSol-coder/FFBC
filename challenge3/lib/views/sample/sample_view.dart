import 'package:flutter/cupertino.dart';

class SampleView extends StatelessWidget {
  const SampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('샘플'),
      ),
      child: SafeArea(
        child: Center(
          child: Text('샘플 화면'),
        ),
      ),
    );
  }
} 