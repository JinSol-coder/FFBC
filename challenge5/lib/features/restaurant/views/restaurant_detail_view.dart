import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../models/menu.dart';
import '../viewmodels/restaurant_detail_viewmodel.dart';

class RestaurantDetailView extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailView({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RestaurantDetailViewModel(restaurantId)..loadMenus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            '메뉴 선택',
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0,
        ),
        body: Consumer<RestaurantDetailViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView(
              children: [
                // 메인 메뉴 섹션
                _buildSection(
                  '메인 메뉴',
                  viewModel.mainMenus,
                  viewModel,
                ),
                // 사이드 메뉴 섹션
                _buildSection(
                  '사이드 메뉴',
                  viewModel.sideMenus,
                  viewModel,
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: Consumer<RestaurantDetailViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '총 ${viewModel.totalPrice}원',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: viewModel.totalPrice > 0
                          ? () => viewModel.addToCart(context)
                          : null,
                      style: AppStyles.primaryButton,
                      child: const Text('장바구니 담기'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Menu> menus,
    RestaurantDetailViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          itemBuilder: (context, index) {
            final menu = menus[index];
            return _MenuCard(
              menu: menu,
              quantity: viewModel.getQuantity(menu.id),
              onIncrease: () => viewModel.increaseQuantity(menu.id),
              onDecrease: () => viewModel.decreaseQuantity(menu.id),
            );
          },
        ),
      ],
    );
  }
}

class _MenuCard extends StatelessWidget {
  final Menu menu;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const _MenuCard({
    required this.menu,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // 메뉴 이미지
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                menu.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // 메뉴 정보
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    menu.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    menu.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${menu.price}원',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
            // 수량 조절 버튼
            Row(
              children: [
                IconButton(
                  onPressed: quantity > 0 ? onDecrease : null,
                  icon: const Icon(Icons.remove),
                ),
                Text(
                  quantity.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
