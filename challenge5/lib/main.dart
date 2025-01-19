import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/cart/viewmodels/cart_viewmodel.dart';
import 'features/home/views/home_view.dart';
import 'core/constants/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: MaterialApp(
        title: '맘마굿',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        home: const HomeView(),
      ),
    );
  }
}
