import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'shared/providers/app_state_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppStateProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
