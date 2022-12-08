import 'dart:convert';
import 'package:flutter_agro_new/database_api/url.dart';
import 'package:flutter_agro_new/models/class_model.dart';
import 'package:http/http.dart' as http;

late ClassModel categoryData;

class CategoryAPI {
  // Future<List<CategoryPModel>> fetchCategory() async {
  //   final response = await http.Client().get(Uri.parse(ApiUrl.getCategory));
  //   return compute(_parseUsers, response.body);
  // }

  // List<CategoryPModel> _parseUsers(String responseBody) {
  //   final parsed = jsonDecode(responseBody)['data'];
  //   return parsed
  //       .map<CategoryPModel>((json) => CategoryPModel.fromJson(json))
  //       .toList();
  // }

  Future getCategory() async {
    http.Response response = await http.get(Uri.parse(ApiUrl.getClass));
    print("response is ${response.body}");
    var resp = jsonDecode(response.body);
    categoryData = ClassModel.fromJson(resp);
    print("conversion done");
    return response.body;
  }
}
