class NotRegisteredUserModel {
  List<NotRegData>? data;

  NotRegisteredUserModel({this.data});

  NotRegisteredUserModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NotRegData>[];
      json['data'].forEach((v) {
        data!.add(new NotRegData.fromJson(v));
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

class NotRegData {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? contactNumber;
  int? roleType;
  Null? password;
  Null? otp;
  Null? ipAddress;
  Null? lastLoginTime;
  String? timezone;
  int? isVeify;
  int? isDelete;
  Null? createdAt;
  Null? updatedAt;

  NotRegData(
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
      this.isDelete,
      this.createdAt,
      this.updatedAt});

  NotRegData.fromJson(Map<String, dynamic> json) {
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
    isDelete = json['is_delete'];
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
    data['is_delete'] = this.isDelete;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
