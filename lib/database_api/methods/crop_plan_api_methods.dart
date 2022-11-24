import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../../models/CropPlanModel.dart';
import '../url.dart';

class CroPlanApiMethods {
  //get
  static Future<List<CropPlanModel>> fetchCropPlan() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getCropPlan));
    return compute(_parseCropPlan, response.body);
  }

  static List<CropPlanModel> _parseCropPlan(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed
        .map<CropPlanModel>((json) => CropPlanModel.fromJson(json))
        .toList();
  }

  //post
  static Future<bool> postCropPlan({
    required int landholderId,
    required int farmId,
    required int blockId,
    required int fieldId,
    required int cropId,
    required int farmerId,
    required String hectarage,
    required String planneddate,
    required int stageId,
  }) async {
    var response = await http.post(
      Uri.parse(ApiUrl.postCropPlan),
      body: {
        "landholder_id": landholderId.toString(),
        "farm_id": farmId.toString(),
        "block_id": blockId.toString(),
        "field_id": fieldId.toString(),
        "crop_id": cropId.toString(),
        "farmer_id": farmerId.toString(),
        "hectarage": hectarage.toString(),
        "planneddate": planneddate.toString(),
        "stage_id": stageId.toString(),
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
