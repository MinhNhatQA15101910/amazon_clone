import 'package:flutter/material.dart';
import 'package:frontend/features/product_details/services/product_details_service.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  const CartProduct({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final _productDetailsService = ProductDetailsService();

  void _increaseQuantity(Product product) {
    _productDetailsService.addToCart(
      context: context,
      product: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(cartItem['product']);
    final quantity = cartItem['quantity'];

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 15,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                width: 120,
                height: 120,
              ),
              Column(
                children: [
                  Container(
                    width: 220,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 220,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 220,
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: const Text(
                      'Eligible for FREE Shipping',
                    ),
                  ),
                  Container(
                    width: 220,
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: Text(
                          quantity.toString(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _increaseQuantity(product),
                      child: Container(
                        width: 35,
                        height: 32,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
