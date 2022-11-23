import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class registerapi {
  Future editDataByUsername(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = await http.Client();

    final prefs = await SharedPreferences.getInstance();

    http.Response response = await _chuckerHttpClient.post(
      Uri.parse(
        ApiConstant.registerAPI,
      ),
      body: updata,
      // headers: {"Accept": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return null;
    } else
      throw (Exception("Search Error"));
  }

  Future register(Map<String, dynamic> updata) async {
    final _chuckerHttpClient = await http.Client();

    final prefs = await SharedPreferences.getInstance();

    http.Response response = await _chuckerHttpClient.post(
      Uri.parse(
        "",
      ),
      body: updata,
      headers: {"Accept": "application/json"},
    );
    print(response.body);
    if (response.statusCode == 200) {
      // final body = json.decode(response.body);
      //  PostByBrandModel brandPosts = PostByBrandModel.fromJson(body);
      print(response.body);
      return null;
    } else
      throw (Exception("Brand Search Error"));
  }
}
