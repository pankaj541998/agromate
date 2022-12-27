import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:flutter_agro_new/models/fetch_Warehouse_Model.dart';
import 'package:http/http.dart' as http;

class stockPlannerAPI {
  static Future<List<fetchWarehouse>> getWarehouse() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getWarehouse));
    return compute(_parseFarms, response.body);
  }

  static List<fetchWarehouse> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<fetchWarehouse>((json) => fetchWarehouse.fromJson(json))
        .toList();
  }
}
