import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetailsService {
  void sellProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': product.id!,
            'rating': rating,
          },
        ),
      );

      httpErrorHandler(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Product Added Successfully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, e.toString());
    }
  }
}
