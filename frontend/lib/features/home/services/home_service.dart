import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeService {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          for (var object in jsonDecode(res.body)) {
            productList.add(
              Product.fromJson(
                jsonEncode(object),
              ),
            );
          }
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, e.toString());
    }

    return productList;
  }
}
