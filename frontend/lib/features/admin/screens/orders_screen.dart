import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/common/widgets/single_product.dart';
import 'package:frontend/features/admin/services/admin_service.dart';
import 'package:frontend/features/order_details/screens/order_details_screen.dart';
import 'package:frontend/models/order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final _adminService = AdminService();

  List<Order>? _orders;

  @override
  void initState() {
    super.initState();
    _fetchAllOrders();
  }

  void _fetchAllOrders() async {
    _orders = await _adminService.fetchAllOrders(context);
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
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: _orders!.length,
            itemBuilder: (context, index) {
              final order = _orders![index];
              return GestureDetector(
                onTap: () => _navigateToOrderDetailsScreen(order),
                child: SizedBox(
                  height: 130,
                  child: SingleProduct(
                    image: order.products[0].images[0],
                  ),
                ),
              );
            },
          );
  }
}
