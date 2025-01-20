import 'package:flutter/material.dart';

import '../../home/models/category.dart';
import '../../home/models/restaurant.dart';
import '../../home/views/widgets/restaurant_card.dart';

class CategoryDetailView extends StatelessWidget {
  final Category category;
  final List<Restaurant> restaurants;

  const CategoryDetailView({
    Key? key,
    required this.category,
    required this.restaurants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          category.name,
          style: const TextStyle(
            color: Colors.deepOrange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.deepOrange),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: RestaurantCard(restaurant: restaurant),
          );
        },
      ),
    );
  }
}
