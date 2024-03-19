import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/common/widgets/single_product.dart';
import 'package:frontend/features/account/services/account_service.dart';
import 'package:frontend/features/order_details/screens/order_details_screen.dart';
import 'package:frontend/models/order.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final _accountService = AccountService();

  List<Order>? _orders;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  void _fetchOrders() async {
    _orders = await _accountService.fetchMyOrders(context);
    setState(() {});
  }

  void _navigateToOrderDetailsScreen(Order order) {
    Navigator.of(context).pushNamed(
      OrderDetailsScreen.routeName,
      arguments: order,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _orders == null
        ? const Loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      'See all',
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),

              // Display Orders
              Container(
                height: 170,
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                  right: 0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _orders!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () =>
                          _navigateToOrderDetailsScreen(_orders![index]),
                      child: SingleProduct(
                        image: _orders![index].products[0].images[0],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
