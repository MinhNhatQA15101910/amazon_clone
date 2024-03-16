import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/features/home/services/home_service.dart';
import 'package:frontend/features/product_details/screens/product_details_screen.dart';
import 'package:frontend/models/product.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final _homeService = HomeService();

  Product? _product;

  void _fetchDealOfDay() async {
    _product = await _homeService.fetchDealOfDay(context: context);
    setState(() {});
  }

  void _navigateToDetailsScreen() {
    Navigator.of(context).pushNamed(
      ProductDetailsScreen.routeName,
      arguments: _product,
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchDealOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return _product == null
        ? const Loader()
        : _product!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: _navigateToDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        'Deal of the day',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Image.network(
                      _product!.images[0],
                      height: 235,
                      fit: BoxFit.contain,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        '\$100.0',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                      ),
                      child: const Text(
                        'Do Nhat',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _product!.images
                            .map(
                              (image) => Row(
                                children: [
                                  Image.network(
                                    image,
                                    fit: BoxFit.contain,
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(width: 10,)
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                        left: 15,
                      ),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
