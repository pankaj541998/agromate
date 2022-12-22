class CropProgramModel {
  List<ProgData>? data;

  CropProgramModel({this.data});

  CropProgramModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProgData>[];
      json['data'].forEach((v) {
        data!.add(new ProgData.fromJson(v));
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

class ProgData {
  int? id;
  String? crop;
  String? cropSeasonDescription;
  String? population;
  String? unitValue;
  String? unit;
  String? weeks;
  String? days;
  String? filePath;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  ProgData(
      {this.id,
      this.crop,
      this.cropSeasonDescription,
      this.population,
      this.unitValue,
      this.unit,
      this.weeks,
      this.days,
      this.filePath,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  ProgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    crop = json['crop'];
    cropSeasonDescription = json['crop_season_description'];
    population = json['population'];
    unitValue = json['unit_value'];
    unit = json['unit'];
    weeks = json['weeks'];
    days = json['days'];
    filePath = json['file_path'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['crop'] = this.crop;
    data['crop_season_description'] = this.cropSeasonDescription;
    data['population'] = this.population;
    data['unit_value'] = this.unitValue;
    data['unit'] = this.unit;
    data['weeks'] = this.weeks;
    data['days'] = this.days;
    data['file_path'] = this.filePath;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
