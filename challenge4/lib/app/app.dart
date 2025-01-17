import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/home/viewmodel/home_viewmodel.dart';
import '../features/search/viewmodel/search_viewmodel.dart';
import '../features/weather/viewmodel/weather_viewmodel.dart';
import '../features/main/view/main_screen.dart';
import '../features/news/viewmodel/news_viewmodel.dart';
import '../features/recommend/viewmodel/recommend_viewmodel.dart';
import '../features/my/viewmodel/my_viewmodel.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => RecommendViewModel()),
        ChangeNotifierProvider(create: (_) => MyViewModel()),
      ],
      child: MaterialApp(
        title: 'News Feed App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MainScreen(),
      ),
    );
  }
} 