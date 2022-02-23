import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpHelper {
  static String _url = 'https://imrans9.sg-host.com/app/app.php';///also defined in http_service


  static Future<http.Response> post({
    @required dynamic body,
  }) async {
    var response = await  http.post(
      Uri.parse(_url),
      body: body,
    );
    if(response.statusCode==503)
    {
      _url = '';

      return http.post(
        Uri.parse(_url),
        body: body,
      );
    }
    else
      return response;
  }
}



