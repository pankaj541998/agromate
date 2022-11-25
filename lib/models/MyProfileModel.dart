class Profile {
  String? token;
  int? userId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? username;
  String? phone;
  String? roleName;

  Profile(
      {this.token,
      this.userId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.email,
      this.username,
      this.phone,
      this.roleName});

  Profile.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['role_name'] = this.roleName;
    return data;
  }
}
