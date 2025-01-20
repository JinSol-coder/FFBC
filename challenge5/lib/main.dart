import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/cart/services/cart_service.dart';
import 'features/cart/viewmodels/cart_viewmodel.dart';
import 'features/home/services/restaurant_service.dart';
import 'features/home/viewmodels/home_viewmodel.dart';
import 'features/home/views/home_view.dart';
import 'features/payment/services/payment_service.dart';
import 'features/restaurant/services/menu_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final restaurantService = RestaurantService();

  runApp(MyApp(
    prefs: prefs,
    restaurantService: restaurantService,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final RestaurantService restaurantService;

  const MyApp({
    Key? key,
    required this.prefs,
    required this.restaurantService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: restaurantService),
        Provider(create: (_) => MenuService()),
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(restaurantService),
        ),
        ChangeNotifierProvider(
          create: (_) => CartService(prefs),
        ),
        Provider(
          create: (_) => PaymentService(prefs),
        ),
        ChangeNotifierProxyProvider<CartService, CartViewModel>(
          create: (context) => CartViewModel(context.read<CartService>()),
          update: (context, cartService, previous) =>
              CartViewModel(cartService)..loadCartItems(),
        ),
      ],
      child: MaterialApp(
        title: '맘마굿',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: 'Pretendard',
        ),
        home: const HomeView(),
      ),
    );
  }
}
