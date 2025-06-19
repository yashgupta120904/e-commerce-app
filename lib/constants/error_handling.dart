import 'dart:convert';

import 'package:ecommerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSucess,
}) {
  switch (response.statusCode) {
    case 200:
      onSucess();
      break;
    case 400:
      showErrorSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showErrorSnackBar(context, jsonDecode(response.body)['error']);
    default:
      showSnackBar(context, response.body);
  }
}
