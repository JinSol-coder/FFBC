import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/storage_service.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/loading_indicator.dart';
import '../../cart/models/cart_item.dart';
import '../viewmodels/payment_viewmodel.dart';

class PaymentView extends StatelessWidget {
  final List<CartItem> cartItems;

  const PaymentView({
    super.key,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentViewModel(
        context.read<StorageService>(),
        cartItems,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.payment),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Consumer<PaymentViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const LoadingIndicator(message: '결제 처리 중...');
            }

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '주문 내역',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            final item = cartItems[index];
                            return ListTile(
                              title: Text(item.menu.name),
                              subtitle: Text('${item.quantity}개'),
                              trailing: Text(
                                '${item.totalPrice.toStringAsFixed(0)}원',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          '결제 수단',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Column(
                            children: [
                              RadioListTile<String>(
                                title: const Text('신용카드'),
                                value: '신용카드',
                                groupValue: viewModel.selectedMethod,
                                onChanged: (value) {
                                  viewModel.updatePaymentMethod(value!);
                                },
                              ),
                              RadioListTile<String>(
                                title: const Text('계좌이체'),
                                value: '계좌이체',
                                groupValue: viewModel.selectedMethod,
                                onChanged: (value) {
                                  viewModel.updatePaymentMethod(value!);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '총 결제금액',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${viewModel.totalAmount.toStringAsFixed(0)}원',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                        text: '${viewModel.totalAmount.toStringAsFixed(0)}원 결제하기',
                        onPressed: () async {
                          await viewModel.processPayment();
                          if (viewModel.error == null) {
                            if (context.mounted) {
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('결제가 완료되었습니다.')),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 