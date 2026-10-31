import 'package:flutter/material.dart';

import '../../core/app_theme.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            tooltip:
                'Carrinho com $itemCount ${itemCount == 1 ? 'item' : 'itens'}',
            onPressed: () {
              final message = itemCount == 0
                  ? 'Seu carrinho ainda está vazio'
                  : '$itemCount ${itemCount == 1 ? 'item' : 'itens'} no carrinho';
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(message)));
            },
            icon: const Icon(Icons.shopping_bag_outlined, size: 27),
          ),
          if (itemCount > 0)
            Positioned(
              right: 0,
              top: 1,
              child: Container(
                constraints: const BoxConstraints(minWidth: 19, minHeight: 19),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  itemCount > 99 ? '99+' : '$itemCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
