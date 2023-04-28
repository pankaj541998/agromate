import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_agro_new/models/crop.dart';
import 'package:flutter_agro_new/models/cropPorgramModel.dart';
import 'package:http/http.dart' as http;

import '../url.dart';

class CropApiMethods {
  //get
  static Future<List<CropPModel>> fetchCrops() async {
    final response = await http.Client()
        .get(Uri.parse("https://agromate.website/laravel/api/get/program"));
    return compute(_parseCrop, response.body);
  }

  static List<CropPModel> _parseCrop(String responseBody) {
    final parsed = jsonDecode(responseBody)['data'];
    return parsed.map<CropPModel>((json) => CropPModel.fromJson(json)).toList();
  }
}
