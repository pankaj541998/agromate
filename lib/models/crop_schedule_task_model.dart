class CropScheduleTasksModel {
  List<CropScheduleTasks>? data;

  CropScheduleTasksModel({this.data});

  CropScheduleTasksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CropScheduleTasks>[];
      json['data'].forEach((v) {
        data!.add(new CropScheduleTasks.fromJson(v));
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

class CropScheduleTasks {
  int? id;
  int? cropPlanId;
  String? week;
  String? status;
  String? title;
  String? description;
  String? category;
  String? chemical;
  String? activeingridient;
  String? quantity;
  String? units;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  CropScheduleTasks(
      {this.id,
      this.cropPlanId,
      this.week,
      this.status,
      this.title,
      this.description,
      this.category,
      this.chemical,
      this.activeingridient,
      this.quantity,
      this.units,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  CropScheduleTasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cropPlanId = json['crop_plan_id'];
    week = json['week'];
    status = json['status'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    chemical = json['chemical'];
    activeingridient = json['activeingridient'];
    quantity = json['quantity'];
    units = json['units'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['crop_plan_id'] = this.cropPlanId;
    data['week'] = this.week;
    data['status'] = this.status;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['chemical'] = this.chemical;
    data['activeingridient'] = this.activeingridient;
    data['quantity'] = this.quantity;
    data['units'] = this.units;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
