import 'dart:convert';
import 'package:http/http.dart' as http;

Future<CropProgramTasks> fetchUsers() async {
  var client = http.Client();
  final response = await client
      .get(Uri.parse('https://agromate.website/laravel/api/get/programtask'));
  final parsed = jsonDecode(response.body);
//  print(response.body);
  var cropdata = CropProgramTasks.fromJson(parsed);
  print(parsed);
  return cropdata;
}

class CropProgramTasks {
  List<Data>? data;

  CropProgramTasks({this.data});

  CropProgramTasks.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? cropprogramid;
  String? week;
  String? day;
  String? status;
  String? date;
  Null? person;
  String? title;
  String? description;
  String? category;
  String? chemical;
  String? activeingridient;
  String? quantity;
  Null? modesofapplication;
  Null? warnings;
  Null? precautions;
  Null? instructions;
  Null? keytargets;
  Null? timeofapplication;
  Null? modesofaction;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.cropprogramid,
      this.week,
      this.day,
      this.status,
      this.date,
      this.person,
      this.title,
      this.description,
      this.category,
      this.chemical,
      this.activeingridient,
      this.quantity,
      this.modesofapplication,
      this.warnings,
      this.precautions,
      this.instructions,
      this.keytargets,
      this.timeofapplication,
      this.modesofaction,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cropprogramid = json['cropprogramid'];
    week = json['week'];
    day = json['day'];
    status = json['status'];
    date = json['date'];
    person = json['person'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    chemical = json['chemical'];
    activeingridient = json['activeingridient'];
    quantity = json['quantity'];
    modesofapplication = json['modesofapplication'];
    warnings = json['warnings'];
    precautions = json['precautions'];
    instructions = json['instructions'];
    keytargets = json['keytargets'];
    timeofapplication = json['timeofapplication'];
    modesofaction = json['modesofaction'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cropprogramid'] = this.cropprogramid;
    data['week'] = this.week;
    data['day'] = this.day;
    data['status'] = this.status;
    data['date'] = this.date;
    data['person'] = this.person;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['chemical'] = this.chemical;
    data['activeingridient'] = this.activeingridient;
    data['quantity'] = this.quantity;
    data['modesofapplication'] = this.modesofapplication;
    data['warnings'] = this.warnings;
    data['precautions'] = this.precautions;
    data['instructions'] = this.instructions;
    data['keytargets'] = this.keytargets;
    data['timeofapplication'] = this.timeofapplication;
    data['modesofaction'] = this.modesofaction;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
