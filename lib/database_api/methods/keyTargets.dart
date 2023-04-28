import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/keytargets.dart';
import 'package:flutter_agro_new/models/warnings.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KeyTargetsAPI {
  //get
  static Future<List<KeyTargetsPModel>> fetchKeyTargets() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getKeyTargets));
    return compute(_parseFarms, response.body);
  }

  static List<KeyTargetsPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<KeyTargetsPModel>((json) => KeyTargetsPModel.fromJson(json))
        .toList();
  }
}
