import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../services/globals.dart';

class testapi {
  testapi();

  Future<http.Response> testAppAPI(Map<String, dynamic> data) async {
    var body = data;
    print("body is $body");
    var url = Uri.parse(baseURL + 'test');
    http.Response response = await http.post(
      url,
      //  headers: headers,
      body: body,
    );
    print(response.body);
    return response;
  }
}
