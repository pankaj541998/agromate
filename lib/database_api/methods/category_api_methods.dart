import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/database_api/models/category.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;

class CategoryAPI {
  static Future<List<CategoryPModel>> fetchCategory() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getCategory));
    return compute(_parseUsers, response.body);
  }

  static List<CategoryPModel> _parseUsers(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<CategoryPModel>((json) => CategoryPModel.fromJson(json))
        .toList();
  }
}
