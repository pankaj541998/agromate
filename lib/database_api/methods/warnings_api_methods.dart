import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/warnings.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WarningsAPI {
  //get
  static Future<List<WarningsPModel>> fetchWarnings() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getWarnings));

    return compute(_parseFarms, response.body);
  }

  static List<WarningsPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<WarningsPModel>((json) => WarningsPModel.fromJson(json))
        .toList();
  }
}
