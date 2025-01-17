import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:challenge4/features/home/view/home_screen.dart';
import 'package:challenge4/features/home/viewmodel/home_viewmodel.dart';

void main() {
  testWidgets('HomeScreen 로딩 상태 테스트', (WidgetTester tester) async {
    final viewModel = HomeViewModel();
    
    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: viewModel,
          child: const HomeScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
} 