import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/stars.dart';
import 'package:frontend/models/product.dart';

class SearchedProduct extends StatelessWidget {
  const SearchedProduct({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (var rating in product.ratings!) {
      totalRating += rating.rating;
    }

    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.ratings!.length;
    }

    return Container(
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
                child: Stars(
                  rating: avgRating,
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
    );
  }
}
