import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_colors.dart';
import '../../cart/models/cart_item.dart';
import '../../cart/services/cart_service.dart';
import '../models/menu.dart';

class MenuDetailView extends StatefulWidget {
  final Menu menu;

  const MenuDetailView({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  State<MenuDetailView> createState() => _MenuDetailViewState();
}

class _MenuDetailViewState extends State<MenuDetailView> {
  int quantity = 1;
  List<Menu> selectedSides = [];

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _toggleSideMenu(Menu sideMenu) {
    setState(() {
      if (selectedSides.contains(sideMenu)) {
        selectedSides.remove(sideMenu);
      } else {
        selectedSides.add(sideMenu);
      }
    });
  }

  int get _totalPrice {
    int sideTotal = selectedSides.fold(0, (sum, item) => sum + item.price);
    return (widget.menu.price * quantity) + sideTotal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.menu.name,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.menu.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.menu.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.menu.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '${widget.menu.price}원',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (widget.menu.sideMenus.isNotEmpty) ...[
                          const SizedBox(height: 24),
                          const Text(
                            '사이드 메뉴',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...widget.menu.sideMenus.map((sideMenu) {
                            bool isSelected = selectedSides.contains(sideMenu);
                            return CheckboxListTile(
                              value: isSelected,
                              onChanged: (_) => _toggleSideMenu(sideMenu),
                              title: Text(sideMenu.name),
                              subtitle: Text('${sideMenu.price}원'),
                            );
                          }),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      quantity.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      final cartItem = CartItem(
                        id: DateTime.now().toString(),
                        menuId: widget.menu.id,
                        menuName: widget.menu.name,
                        price: widget.menu.price,
                        imageUrl: widget.menu.imageUrl,
                        quantity: quantity,
                      );

                      context.read<CartService>().addItem(cartItem);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('장바구니에 추가되었습니다')),
                      );

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      '${widget.menu.price * quantity}원 담기',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
