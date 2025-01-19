import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/viewmodels/cart_viewmodel.dart';
import '../../home/models/menu_item.dart';
import '../viewmodels/menu_detail_viewmodel.dart';

class MenuDetailView extends StatelessWidget {
  final MenuItem menu;

  const MenuDetailView({
    super.key,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MenuDetailViewModel(menu),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('메뉴 상세'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: AppColors.grey,
                      child: const Center(
                        child: Icon(Icons.restaurant_menu, size: 64),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            menu.description,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${menu.price.toStringAsFixed(0)}원',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Consumer<MenuDetailViewModel>(
                            builder: (context, viewModel, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: viewModel.decrementQuantity,
                                    icon: const Icon(Icons.remove),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    '${viewModel.quantity}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    onPressed: viewModel.incrementQuantity,
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Consumer<MenuDetailViewModel>(
                builder: (context, viewModel, child) {
                  return CustomButton(
                    text: '${viewModel.totalPrice.toStringAsFixed(0)}원 담기',
                    onPressed: () {
                      final cartViewModel = context.read<CartViewModel>();
                      cartViewModel.addToCart(
                        CartItem(
                          menu: menu,
                          quantity: viewModel.quantity,
                        ),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('장바구니에 추가되었습니다.')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
} 