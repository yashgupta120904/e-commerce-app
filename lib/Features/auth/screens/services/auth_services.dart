import 'dart:convert';

import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/constants/utils.dart';
import 'package:ecommerce_app/providers/user_provider.dart';

import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
  }) async {
    try {
      // Step 1: Local validation
      if (password != confirmPassword) {
        showSnackBar(context, "Passwords do not match ");
        return;
      }

      // Step 2: Proceed if password matches
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

      httpErrorHandle(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSucess: () {
          showSnackBar(context, 'Congratulation!! Account Created ✅');
        },
      );
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print(res.body);

      httpErrorHandle(
        response: res,
        // ignore: use_build_context_synchronously
        context: context,
        onSucess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        },
      );
    } catch (e) {
      showErrorSnackBar(context, e.toString());
    }
  }
}
