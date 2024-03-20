import 'package:flutter/material.dart';
import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:frontend/features/admin/models/sale.dart';

class CategoryProductsChart extends StatelessWidget {
  const CategoryProductsChart({
    super.key,
    required this.seriesList,
  });

  final List<charts.Series<Sale, String>> seriesList;

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: true,
    );
  }
}
