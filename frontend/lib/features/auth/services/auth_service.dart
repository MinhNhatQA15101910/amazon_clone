import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/bottom_bar.dart';
import 'package:frontend/constants/error_handling.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () {
          showSnackbar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, error.toString());
    }
  }

  // Sign In User
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: '',
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, error.toString());
    }
  }

  // Get User Data
  void getUserData(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var isValidToken = jsonDecode(tokenRes.body);

      if (isValidToken) {
        http.Response userRes = await http.get(
          Uri.parse('$uri/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false).setUser(userRes.body);
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      showSnackbar(context, error.toString());
    }
  }
}
