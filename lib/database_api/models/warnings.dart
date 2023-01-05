class WarningsPModel {
  final int? id;
  final String? warnings;

  const WarningsPModel({
    required this.id,
    required this.warnings,
  });

  factory WarningsPModel.fromJson(Map<String, dynamic> json) {
    return WarningsPModel(
      id: json['id'] as int?,
      warnings: json['warning_name'] as String?,
    );
  }
}
