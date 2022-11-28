// ignore_for_file: file_names

import 'package:flutter_agro_new/component/services/constants.dart';
import 'package:http/http.dart' as http;

class ProgramApiMethods {
  Future<String> postCropProgram(CropProgram cropProgram) async {
    final response = await http.post(
      Uri.parse(ApiConstant.addProgramAPI),
      body: <String, String>{
        'crop': cropProgram.crop,
        'population': cropProgram.plantPopulation,
        'yield': cropProgram.yeild,
        'weeks': cropProgram.weeks,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return 'Error';
    }
  }
}

class CropProgram {
  CropProgram({
    required this.crop,
    required this.plantPopulation,
    required this.yeild,
    required this.weeks,
  });
  String crop;
  String plantPopulation;
  String yeild;
  String weeks;

  static List<CropProgram> cropPrograms = [];
}

class CropProgramTask {
  CropProgramTask({
    this.cropProgramId,
    this.week,
    this.day,
    this.date,
    this.title,
    this.description,
    this.category,
    this.chemical,
    this.activeIngredient,
    this.quantity,
    this.unit,
    this.status,
  });

  String? cropProgramId;

  String? week;
  String? day;
  String? date;

  String? title;
  String? description;

  String? category;
  String? chemical;
  String? activeIngredient;
  String? quantity;
  String? unit;

  String? status;
}

List<CropProgramTask> cropProgramTasks = [];
