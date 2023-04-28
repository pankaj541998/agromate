import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/modes.dart';
import 'package:flutter_agro_new/models/type.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ModesAPI {
  //get
  static Future<List<ModesPModel>> fetchModes() async {
    final response =
        await http.Client().get(Uri.parse(ApiUrl.getModesOfApplication));
    return compute(_parseFarms, response.body);
  }

  static List<ModesPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<ModesPModel>((json) => ModesPModel.fromJson(json))
        .toList();
  }
}
