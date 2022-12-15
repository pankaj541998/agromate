class CropPlanModel {
  List<Data>? data;

  CropPlanModel({this.data});

  CropPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? farmId;
  int? blockId;
  int? fieldId;
  String? cropReference;
  int? cropProgramId;
  String? caltivar;
  int? farmerId;
  String? startDate;
  String? expectedEndDate;
  String? area;
  String? expectedYield;
  String? expectedRevenue;
  String? harvestDays;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<Farm>? farm;
  List<Block>? block;
  List<Field>? field;
  List<CropProgram>? cropProgram;

  Data(
      {this.id,
      this.farmId,
      this.blockId,
      this.fieldId,
      this.cropReference,
      this.cropProgramId,
      this.caltivar,
      this.farmerId,
      this.startDate,
      this.expectedEndDate,
      this.area,
      this.expectedYield,
      this.expectedRevenue,
      this.harvestDays,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.farm,
      this.block,
      this.field,
      this.cropProgram});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmId = json['farm_id'];
    blockId = json['block_id'];
    fieldId = json['field_id'];
    cropReference = json['crop_reference'];
    cropProgramId = json['crop_program_id'];
    caltivar = json['caltivar'];
    farmerId = json['farmer_id'];
    startDate = json['start_date'];
    expectedEndDate = json['expected_end_date'];
    area = json['area'];
    expectedYield = json['expected_yield'];
    expectedRevenue = json['expected_revenue'];
    harvestDays = json['harvest_days'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['farm'] != null) {
      farm = <Farm>[];
      json['farm'].forEach((v) {
        farm!.add(Farm.fromJson(v));
      });
    }
    if (json['block'] != null) {
      block = <Block>[];
      json['block'].forEach((v) {
        block!.add(Block.fromJson(v));
      });
    }
    if (json['field'] != null) {
      field = <Field>[];
      json['field'].forEach((v) {
        field!.add(Field.fromJson(v));
      });
    }
    if (json['crop_program'] != null) {
      cropProgram = <CropProgram>[];
      json['crop_program'].forEach((v) {
        cropProgram!.add(CropProgram.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['farm_id'] = this.farmId;
    data['block_id'] = this.blockId;
    data['field_id'] = this.fieldId;
    data['crop_reference'] = this.cropReference;
    data['crop_program_id'] = this.cropProgramId;
    data['caltivar'] = this.caltivar;
    data['farmer_id'] = this.farmerId;
    data['start_date'] = this.startDate;
    data['expected_end_date'] = this.expectedEndDate;
    data['area'] = this.area;
    data['expected_yield'] = this.expectedYield;
    data['expected_revenue'] = this.expectedRevenue;
    data['harvest_days'] = this.harvestDays;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.farm != null) {
      data['farm'] = this.farm!.map((v) => v.toJson()).toList();
    }
    if (this.block != null) {
      data['block'] = this.block!.map((v) => v.toJson()).toList();
    }
    if (this.field != null) {
      data['field'] = this.field!.map((v) => v.toJson()).toList();
    }
    if (this.cropProgram != null) {
      data['crop_program'] = this.cropProgram!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Farm {
  int? id;
  int? landholderId;
  String? farm;
  String? farmLatlong;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  Farm(
      {this.id,
      this.landholderId,
      this.farm,
      this.farmLatlong,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  Farm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landholderId = json['landholder_id'];
    farm = json['farm'];
    farmLatlong = json['farm_latlong'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['landholder_id'] = this.landholderId;
    data['farm'] = this.farm;
    data['farm_latlong'] = this.farmLatlong;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Block {
  int? id;
  int? landholderId;
  int? farmId;
  String? block;
  String? blockLatlong;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  Block(
      {this.id,
      this.landholderId,
      this.farmId,
      this.block,
      this.blockLatlong,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  Block.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landholderId = json['landholder_id'];
    farmId = json['farm_id'];
    block = json['block'];
    blockLatlong = json['block_latlong'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['landholder_id'] = this.landholderId;
    data['farm_id'] = this.farmId;
    data['block'] = this.block;
    data['block_latlong'] = this.blockLatlong;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Field {
  int? id;
  int? landholderId;
  int? farmId;
  int? blockId;
  String? field;
  String? fieldLatlong;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  Field(
      {this.id,
      this.landholderId,
      this.farmId,
      this.blockId,
      this.field,
      this.fieldLatlong,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landholderId = json['landholder_id'];
    farmId = json['farm_id'];
    blockId = json['block_id'];
    field = json['field'];
    fieldLatlong = json['field_latlong'];
    isActive = json['is_active'];
    isDelete = json['is_delete'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['landholder_id'] = this.landholderId;
    data['farm_id'] = this.farmId;
    data['block_id'] = this.blockId;
    data['field'] = this.field;
    data['field_latlong'] = this.fieldLatlong;
    data['is_active'] = this.isActive;
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CropProgram {
  int? id;
  String? crop;
  String? population;
  String? yield;
  String? weeks;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  CropProgram(
      {this.id,
      this.crop,
      this.population,
      this.yield,
      this.weeks,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  CropProgram.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    crop = json['crop'];
    population = json['population'];
    yield = json['yield'];
    weeks = json['weeks'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['crop'] = this.crop;
    data['population'] = this.population;
    data['yield'] = this.yield;
    data['weeks'] = this.weeks;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
