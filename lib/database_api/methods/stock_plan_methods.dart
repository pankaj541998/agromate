import 'dart:convert';
import 'package:flutter_agro_new/models/stock_plan_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/foundation.dart';

import '../url.dart';

class StockPlanApiMethods {
  //get
  static Future<List<StockPlanModel>> fetchStockPlan() async {
    final response = await http.Client().get(Uri.parse(ApiUrl.getClass));
    return compute(_parseStockPlan, response.body);
  }

  static List<StockPlanModel> _parseStockPlan(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return parsed
        .map<StockPlanModel>((json) => StockPlanModel.fromJson(json))
        .toList();
  }

  //post
  static Future<bool> postStockPlan({
    required int warehouse_id,
    required int end_date,
    required int stock_name,
    required int quantity,
  }) async {
    var response = await http.post(
      Uri.parse(ApiUrl.postCropPlan),
      body: {
        "warehouse_id": warehouse_id.toString(),
        "end_date": end_date.toString(),
        "stock_name": stock_name.toString(),
        "quantity": quantity.toString(),
      },
    );
    if (response.statusCode == 200) return true;
    return false;
  }
}
