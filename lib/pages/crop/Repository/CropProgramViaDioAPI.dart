import 'dart:convert';

import 'package:flutter_agro_new/base_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_agro_new/models/CropProgramTasksModel.dart';

import 'package:shared_preferences/shared_preferences.dart';

late CropProgramTasks diocropdata;

class getCropProgramData {
  Dio dio = new Dio();

  Future<ResponseData> getSecurityQuestions(int id) async {
    Response response;

    try {
      response = await dio.get(
        'https://agromate.website/laravel/api/crop_program_task/$id',
      );
    } on Exception catch (_) {
      return ResponseData<dynamic>(
          'Invalid Credentials', ResponseStatus.FAILED);
    }

    if (response.statusCode == 200) {
      print("response from api is ${response.data}");
      diocropdata = CropProgramTasks.fromJson(response.data);
      print("json to dart done");
      return ResponseData<dynamic>(
        "success",
        ResponseStatus.SUCCESS,
      );
    } else {
      try {
        return ResponseData<dynamic>(
            response.data['message'].toString(), ResponseStatus.FAILED);
      } catch (_) {
        return ResponseData<dynamic>(
            response.statusMessage!, ResponseStatus.FAILED);
      }
    }
  }
}
