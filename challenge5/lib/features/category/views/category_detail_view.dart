import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../home/models/category.dart';
import '../../home/models/restaurant.dart';
import '../../home/views/widgets/restaurant_list.dart';

class CategoryDetailView extends StatelessWidget {
  final Category category;
  final List<Restaurant> restaurants;

  const CategoryDetailView({
    super.key,
    required this.category,
    required this.restaurants,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          category.name,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      body: RestaurantList(
        restaurants: restaurants,
        onRestaurantSelected: (restaurant) {
          // TODO: 식당 상세 페이지로 이동
        },
      ),
    );
  }
} 