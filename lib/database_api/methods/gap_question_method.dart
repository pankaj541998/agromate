import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;

import '../../models/gapCategoryModel.dart';
import '../../models/gapQuestionModel.dart';
import '../url.dart';

late GapCategory gapData;
late GapQuestion gapQuestion;

class GapQuestionMethods {
  //get
  // static Future<List<GapQuestion>> getGap() async {
  //   final response = await http.Client().get(Uri.parse(ApiUrl.getGap));
  //   return compute(_parseFarms, response.body);
  // }

  // static List<GapQuestion> _parseFarms(String responseBody) {
  //   final parsed = jsonDecode(responseBody);
  //   return parsed
  //       .map<GapQuestion>((json) => GapQuestion.fromJson(json))
  //       .toList();
  // }

// get question

  Future getQuestion() async {
    http.Response response = await http.get(Uri.parse(ApiUrl.getGap));

    var resp = jsonDecode(response.body);
    gapQuestion = GapQuestion.fromJson(resp);

    return response.body;
  }

// get category

  Future getCategory() async {
    http.Response response = await http.get(Uri.parse(ApiUrl.getCategory));

    var resp = jsonDecode(response.body);
    gapData = GapCategory.fromJson(resp);

    return response.body;
  }

  // //post
  // static Future<bool> postGapQuestion({
  //   required int gapCategoryId,
  //   required String question,
  //   required int options,
  //   required int text,
  //   required int image,
  // }) async {
  //   var response = await http.post(
  //     Uri.parse(ApiUrl.postGap),
  //     body: {
  //       "gap_category_id": gapCategoryId,
  //       "question": question,
  //       "options": options,
  //       "text": text,
  //       "image": image,
  //     },
  //   );
  //   if (response.statusCode == 200) return true;
  //   return false;
  // }
}
