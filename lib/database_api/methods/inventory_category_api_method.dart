import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/database_api/models/category.dart';
import 'package:flutter_agro_new/database_api/models/gap.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InventoryCategoryAPI {
  //get
  static Future<List<CategoryPModel>> fetchcat() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getClass));
    return compute(_parseFarms, response.body);
  }

  static List<CategoryPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<CategoryPModel>((json) => CategoryPModel.fromJson(json))
        .toList();
  }
}
