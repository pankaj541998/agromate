class stockOrderModel {
  List<StockOrderData>? data;

  stockOrderModel({this.data});

  stockOrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StockOrderData>[];
      json['data'].forEach((v) {
        data!.add(new StockOrderData.fromJson(v));
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

class StockOrderData {
  int? id;
  int? farmId;
  int? blockId;
  int? fieldId;
  int? cropId;
  int? warehouseId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  List<Farm>? farm;
  List<Block>? block;
  List<Field>? field;
  List<Crop>? crop;
  List<Warehouse>? warehouse;
  List<User>? user;

  StockOrderData(
      {this.id,
      this.farmId,
      this.blockId,
      this.fieldId,
      this.cropId,
      this.warehouseId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.farm,
      this.block,
      this.field,
      this.crop,
      this.warehouse,
      this.user});

  StockOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmId = json['farm_id'];
    blockId = json['block_id'];
    fieldId = json['field_id'];
    cropId = json['crop_id'];
    warehouseId = json['warehouse_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['farm'] != null) {
      farm = <Farm>[];
      json['farm'].forEach((v) {
        farm!.add(new Farm.fromJson(v));
      });
    }
    if (json['block'] != null) {
      block = <Block>[];
      json['block'].forEach((v) {
        block!.add(new Block.fromJson(v));
      });
    }
    if (json['field'] != null) {
      field = <Field>[];
      json['field'].forEach((v) {
        field!.add(new Field.fromJson(v));
      });
    }
    if (json['crop'] != null) {
      crop = <Crop>[];
      json['crop'].forEach((v) {
        crop!.add(new Crop.fromJson(v));
      });
    }
    if (json['warehouse'] != null) {
      warehouse = <Warehouse>[];
      json['warehouse'].forEach((v) {
        warehouse!.add(new Warehouse.fromJson(v));
      });
    }
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farm_id'] = this.farmId;
    data['block_id'] = this.blockId;
    data['field_id'] = this.fieldId;
    data['crop_id'] = this.cropId;
    data['warehouse_id'] = this.warehouseId;
    data['user_id'] = this.userId;
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
    if (this.crop != null) {
      data['crop'] = this.crop!.map((v) => v.toJson()).toList();
    }
    if (this.warehouse != null) {
      data['warehouse'] = this.warehouse!.map((v) => v.toJson()).toList();
    }
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Crop {
  int? id;
  String? crop;
  String? cropSeasonDescription;
  String? population;
  int? unitValue;
  String? unit;
  String? weeks;
  String? days;
  Null? filePath;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Crop(
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

  Crop.fromJson(Map<String, dynamic> json) {
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

class Warehouse {
  int? id;
  String? warehouseName;
  int? isActive;
  Null? createdAt;
  Null? updatedAt;

  Warehouse(
      {this.id,
      this.warehouseName,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  Warehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseName = json['warehouse_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_name'] = this.warehouseName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  Null? otp;
  Null? ipAddress;
  Null? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.email,
      this.contactNumber,
      this.roleType,
      this.password,
      this.otp,
      this.ipAddress,
      this.lastLoginTime,
      this.timezone,
      this.isVeify,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    userName = json['user_name'];
    email = json['email'];
    contactNumber = json['contact_number'];
    roleType = json['role_type'];
    password = json['password'];
    otp = json['otp'];
    ipAddress = json['ip_address'];
    lastLoginTime = json['last_login_time'];
    timezone = json['timezone'];
    isVeify = json['is_veify'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['contact_number'] = this.contactNumber;
    data['role_type'] = this.roleType;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['ip_address'] = this.ipAddress;
    data['last_login_time'] = this.lastLoginTime;
    data['timezone'] = this.timezone;
    data['is_veify'] = this.isVeify;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
