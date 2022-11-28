import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/farm.dart';

import 'package:http/http.dart' as http;

import '../url.dart';

class FarmApiMethods {
  //get
  static Future<List<FarmModel>> fetchFarms() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getFarms));
    return compute(_parseFarms, response.body);
  }

  static List<FarmModel> _parseFarms(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<FarmModel>((json) => FarmModel.fromJson(json)).toList();
  }

  //post
  static Future<bool> postFarm({
    required int landholderId,
    required String farmName,
    required String farmLatLngs,
  }) async {
    var response = await http.post(
      Uri.parse(ApiUrl.postFarm),
      body: {
        "landholder_id": landholderId.toString(),
        "farm": farmName,
        "farm_latlong": farmLatLngs,
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
