import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/home/viewmodel/home_viewmodel.dart';
import '../features/search/viewmodel/search_viewmodel.dart';
import '../features/weather/viewmodel/weather_viewmodel.dart';
import '../features/main/view/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
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