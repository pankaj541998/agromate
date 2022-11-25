class CropProgramModel {
  List<Data>? data;

  CropProgramModel({this.data});

  CropProgramModel.fromJson(Map<String, dynamic> json) {
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
  String? crop;
  String? population;
  String? yield;
  String? weeks;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.crop,
      this.population,
      this.yield,
      this.weeks,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    crop = json['crop'];
    population = json['population'];
    yield = json['yield'];
    weeks = json['weeks'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['crop'] = this.crop;
    data['population'] = this.population;
    data['yield'] = this.yield;
    data['weeks'] = this.weeks;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
