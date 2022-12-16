import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/database_api/models/gap.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GapCatAPI {
  //get
  static Future<List<GapQuestionListModel>> fetchgapcat() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getCategory));
    return compute(_parseFarms, response.body);
  }

  static List<GapQuestionListModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<GapQuestionListModel>(
            (json) => GapQuestionListModel.fromJson(json))
        .toList();
  }
}
