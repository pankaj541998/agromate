import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/timeofapplication.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TimeOfApplicationAPI {
  //get
  static Future<List<TimeOFApplicationPModel>> fetchTimeOfApplication() async {
    final response =
        await http.Client().get(Uri.parse(ApiUrl.getTimeOfApplication));
    return compute(_parseFarms, response.body);
  }

  static List<TimeOFApplicationPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<TimeOFApplicationPModel>(
            (json) => TimeOFApplicationPModel.fromJson(json))
        .toList();
  }
}
