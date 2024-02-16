import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            jsonDecode(response.body)['message'],
          ),
        ),
      );
      break;
    case 500:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            jsonDecode(response.body)['error'],
          ),
        ),
      );
      break;
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong',
          ),
        ),
      );
  }
}
