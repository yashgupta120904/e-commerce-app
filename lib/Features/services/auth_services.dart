import 'package:ecommerce_app/constants/error_handling.dart';
import 'package:ecommerce_app/constants/global_variable.dart';
import 'package:ecommerce_app/constants/utils.dart';

import 'package:ecommerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<void> signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          }); //make cleaner format
      httpErrorHandle(
          response: res,
          // ignore: use_build_context_synchronously
          context: context,
          onSucess: () {
            showSnackBar(context, 'Account Created');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
