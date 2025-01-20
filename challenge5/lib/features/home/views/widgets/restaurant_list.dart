import 'package:flutter/material.dart';

import '../../../../core/constants/app_styles.dart';
import '../../models/restaurant.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restaurants;
  final Function(Restaurant) onRestaurantSelected;

  const RestaurantList({
    super.key,
    required this.restaurants,
    required this.onRestaurantSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        final restaurant = restaurants[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AnimatedContainer(
            duration: AppStyles.animationDuration,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onRestaurantSelected(restaurant),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: AppStyles.cardDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(restaurant.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: AppStyles.heading2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                restaurant.description,
                                style: AppStyles.body2,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: AppStyles.body2.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (restaurant.hasDiscount) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '${restaurant.discountRate}% 할인',
                                      style: AppStyles.body2.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
