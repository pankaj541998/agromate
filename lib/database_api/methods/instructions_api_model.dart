import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/instructions.dart';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstructionsAPI {
  //get
  static Future<List<InstructionsPModel>> fetchInstructions() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getInstructions));
    return compute(_parseFarms, response.body);
  }

  static List<InstructionsPModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed
        .map<InstructionsPModel>((json) => InstructionsPModel.fromJson(json))
        .toList();
  }
}
