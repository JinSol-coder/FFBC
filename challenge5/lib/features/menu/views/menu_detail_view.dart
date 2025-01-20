import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../shared/widgets/custom_button.dart';
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
      create: (_) => MenuDetailViewModel(
        menu: menu,
        restaurantId: menu.restaurantId,
        restaurantName: menu.restaurantName,
      ),
      child: Consumer<CartViewModel>(
        builder: (context, cartViewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[50],
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.primary),
            ),
            body: Consumer<MenuDetailViewModel>(
              builder: (context, viewModel, child) {
                return Column(
                  children: [
                    Image.network(
                      menu.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          width: double.infinity,
                          color: AppColors.grey.withOpacity(0.2),
                          child: const Icon(
                            Icons.restaurant,
                            size: 64,
                            color: AppColors.grey,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: AppStyles.heading1,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            menu.description,
                            style: AppStyles.body1,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '${menu.price}원',
                            style: AppStyles.heading2.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: viewModel.decrementQuantity,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                '${viewModel.quantity}',
                                style: AppStyles.heading2,
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: viewModel.incrementQuantity,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        text: '${viewModel.totalPrice}원 담기',
                        onPressed: () {
                          cartViewModel.addItem(viewModel.toCartItem());
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
