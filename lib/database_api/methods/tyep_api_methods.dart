import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/type.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TypeAPI {
  //get
  static Future<List<TypePModel>> fetchtype() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getType));
    return compute(_parseFarms, response.body);
  }

  static List<TypePModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<TypePModel>((json) => TypePModel.fromJson(json)).toList();
  }
}
