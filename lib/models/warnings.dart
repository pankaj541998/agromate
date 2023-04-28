class WarningsPModel {
  final int? id;
  late final String? warnings;

  WarningsPModel({
    this.id,
    this.warnings,
  });

  factory WarningsPModel.fromJson(Map<String, dynamic> json) {
    return WarningsPModel(
      id: json['id'] as int?,
      warnings: json['warning_name'] as String?,
    );
  }
}
