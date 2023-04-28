import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/precautions.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PrecautionsAPI {
  //get
  static Future<List<PrecautionsPModel>> fetchPrecautions() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getPrecautions));
    return compute(_parseFarms, response.body);
  }

  static List<PrecautionsPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<PrecautionsPModel>((json) => PrecautionsPModel.fromJson(json))
        .toList();
  }
}
