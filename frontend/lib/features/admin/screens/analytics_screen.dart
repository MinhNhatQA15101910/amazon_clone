import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/loader.dart';
import 'package:frontend/features/admin/models/sale.dart';
import 'package:frontend/features/admin/services/admin_service.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _adminService = AdminService();
  int? totalEarnings;
  List<Sale>? sales;

  void _getEarnings() async {
    var earningData = await _adminService.getEarnings(context);
    totalEarnings = earningData['totalEarnings'];
    sales = earningData['sales'];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return totalEarnings == null || sales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalEarnings',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
  }
}
