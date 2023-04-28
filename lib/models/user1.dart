class UserModel {
  final String? firstName;
  final String? lastName;
  final int? roleIndex;
  final int? id;

  const UserModel({
    required this.firstName,
    required this.lastName,
    required this.roleIndex,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      roleIndex: json['role_type'] as int?,
      id: json['id'] as int?,
    );
  }
}
