class allocationModel {
  List<allocationData>? data;

  allocationModel({this.data});

  allocationModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <allocationData>[];
      json['data'].forEach((v) {
        data!.add(new allocationData.fromJson(v));
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

class allocationData {
  int? id;
  int? landholderId;
  int? farmId;
  int? agronomistId;
  int? managerId;
  int? blockId;
  int? fieldId;
  int? farmerId;
  int? labourerId;
  String? createdAt;
  String? updatedAt;
  List<GetLandholder>? getLandholder;
  List<GetFarm>? getFarm;
  List<GetAgronomist>? getAgronomist;
  List<GetManager>? getManager;
  List<GetBlock>? getBlock;
  List<GetField>? getField;
  List<GetFarmer>? getFarmer;
  List<GetLabourer>? getLabourer;

  allocationData(
      {this.id,
      this.landholderId,
      this.farmId,
      this.agronomistId,
      this.managerId,
      this.blockId,
      this.fieldId,
      this.farmerId,
      this.labourerId,
      this.createdAt,
      this.updatedAt,
      this.getLandholder,
      this.getFarm,
      this.getAgronomist,
      this.getManager,
      this.getBlock,
      this.getField,
      this.getFarmer,
      this.getLabourer});

  allocationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landholderId = json['landholder_id'];
    farmId = json['farm_id'];
    agronomistId = json['agronomist_id'];
    managerId = json['manager_id'];
    blockId = json['block_id'];
    fieldId = json['field_id'];
    farmerId = json['farmer_id'];
    labourerId = json['labourer_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['get_landholder'] != null) {
      getLandholder = <GetLandholder>[];
      json['get_landholder'].forEach((v) {
        getLandholder!.add(new GetLandholder.fromJson(v));
      });
    }
    if (json['get_farm'] != null) {
      getFarm = <GetFarm>[];
      json['get_farm'].forEach((v) {
        getFarm!.add(new GetFarm.fromJson(v));
      });
    }
    if (json['get_agronomist'] != null) {
      getAgronomist = <GetAgronomist>[];
      json['get_agronomist'].forEach((v) {
        getAgronomist!.add(new GetAgronomist.fromJson(v));
      });
    }
    if (json['get_manager'] != null) {
      getManager = <GetManager>[];
      json['get_manager'].forEach((v) {
        getManager!.add(new GetManager.fromJson(v));
      });
    }
    if (json['get_block'] != null) {
      getBlock = <GetBlock>[];
      json['get_block'].forEach((v) {
        getBlock!.add(new GetBlock.fromJson(v));
      });
    }
    if (json['get_field'] != null) {
      getField = <GetField>[];
      json['get_field'].forEach((v) {
        getField!.add(new GetField.fromJson(v));
      });
    }
    if (json['get_farmer'] != null) {
      getFarmer = <GetFarmer>[];
      json['get_farmer'].forEach((v) {
        getFarmer!.add(new GetFarmer.fromJson(v));
      });
    }
    if (json['get_labourer'] != null) {
      getLabourer = <GetLabourer>[];
      json['get_labourer'].forEach((v) {
        getLabourer!.add(new GetLabourer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['landholder_id'] = this.landholderId;
    data['farm_id'] = this.farmId;
    data['agronomist_id'] = this.agronomistId;
    data['manager_id'] = this.managerId;
    data['block_id'] = this.blockId;
    data['field_id'] = this.fieldId;
    data['farmer_id'] = this.farmerId;
    data['labourer_id'] = this.labourerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.getLandholder != null) {
      data['get_landholder'] =
          this.getLandholder!.map((v) => v.toJson()).toList();
    }
    if (this.getFarm != null) {
      data['get_farm'] = this.getFarm!.map((v) => v.toJson()).toList();
    }
    if (this.getAgronomist != null) {
      data['get_agronomist'] =
          this.getAgronomist!.map((v) => v.toJson()).toList();
    }
    if (this.getManager != null) {
      data['get_manager'] = this.getManager!.map((v) => v.toJson()).toList();
    }
    if (this.getBlock != null) {
      data['get_block'] = this.getBlock!.map((v) => v.toJson()).toList();
    }
    if (this.getField != null) {
      data['get_field'] = this.getField!.map((v) => v.toJson()).toList();
    }
    if (this.getFarmer != null) {
      data['get_farmer'] = this.getFarmer!.map((v) => v.toJson()).toList();
    }
    if (this.getLabourer != null) {
      data['get_labourer'] = this.getLabourer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetLandholder {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  String? otp;
  String? ipAddress;
  String? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  GetLandholder(
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

  GetLandholder.fromJson(Map<String, dynamic> json) {
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

class GetFarm {
  int? id;
  int? landholderId;
  String? farm;
  String? farmLatlong;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  GetFarm(
      {this.id,
      this.landholderId,
      this.farm,
      this.farmLatlong,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  GetFarm.fromJson(Map<String, dynamic> json) {
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

class GetBlock {
  int? id;
  int? landholderId;
  int? farmId;
  String? block;
  String? blockLatlong;
  int? isActive;
  int? isDelete;
  String? createdAt;
  String? updatedAt;

  GetBlock(
      {this.id,
      this.landholderId,
      this.farmId,
      this.block,
      this.blockLatlong,
      this.isActive,
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  GetBlock.fromJson(Map<String, dynamic> json) {
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

class GetField {
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

  GetField(
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

  GetField.fromJson(Map<String, dynamic> json) {
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

class GetManager {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  String? otp;
  String? ipAddress;
  String? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  GetManager(
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

  GetManager.fromJson(Map<String, dynamic> json) {
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

class GetFarmer {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  String? otp;
  String? ipAddress;
  String? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  GetFarmer(
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

  GetFarmer.fromJson(Map<String, dynamic> json) {
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

class GetLabourer {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  String? otp;
  String? ipAddress;
  String? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  GetLabourer(
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

  GetLabourer.fromJson(Map<String, dynamic> json) {
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

class GetAgronomist {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  String? password;
  String? otp;
  String? ipAddress;
  String? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  GetAgronomist(
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

  GetAgronomist.fromJson(Map<String, dynamic> json) {
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
