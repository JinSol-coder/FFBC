import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../models/category.dart';

class CategoryList extends StatelessWidget {
  final List<Category> categories;
  final Function(Category) onCategorySelected;

  const CategoryList({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 16,
        runSpacing: 16,
        children: categories.map((category) => _buildCategoryItem(category)).toList(),
      ),
    );
  }

  Widget _buildCategoryItem(Category category) {
    return InkWell(
      onTap: () => onCategorySelected(category),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getCategoryIcon(category.name),
                color: AppColors.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String categoryName) {
    switch (categoryName) {
      case '한식':
        return Icons.rice_bowl;  // 밥그릇 아이콘
      case '중식':
        return Icons.ramen_dining;  // 면/젓가락 아이콘
      case '일식':
        return Icons.set_meal;  // 초밥 아이콘
      case '양식':
        return Icons.restaurant;  // 포크와 나이프 아이콘
      case '치킨':
        return Icons.lunch_dining;  // 치킨 아이콘
      case '피자':
        return Icons.local_pizza;  // 피자 아이콘
      case '분식':
        return Icons.bakery_dining;  // 떡볶이/분식 아이콘
      case '디저트':
        return Icons.cake;  // 케이크 아이콘
      default:
        return Icons.restaurant_menu;
    }
  }
} 