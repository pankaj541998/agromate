import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/field.dart';
import '../url.dart';

class FieldApiMethods {
  //post
  static Future<bool> postField({
    required int landholderId,
    required int farmId,
    required int blockId,
    required String fieldName,
    required String fieldLatLngs,
  }) async {
    var response = await http.post(
      Uri.parse(ApiUrl.postField),
      body: {
        "landholder_id": landholderId.toString(),
        "farm_id": farmId.toString(),
        "block_id": blockId.toString(),
        "field": fieldName.toString(),
        "field_latlong": fieldLatLngs,
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }

  //get
  static Future<List<FieldModel>> fetchFields() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getFields));
    return compute(_parseField, response.body);
  }

  static List<FieldModel> _parseField(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<FieldModel>((json) => FieldModel.fromJson(json)).toList();
  }
}
