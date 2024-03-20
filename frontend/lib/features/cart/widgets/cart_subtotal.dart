import 'package:flutter/material.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    var subtotal = 0.0;

    user.cart
        .map(
          (item) =>
              subtotal += item['quantity'] * item['product']['price'] as double,
        )
        .toList();

    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal: ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            '\$$subtotal',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
