class PrecautionsPModel {
  final int? id;
  final String? precautions;

  const PrecautionsPModel({
    required this.id,
    required this.precautions,
  });

  factory PrecautionsPModel.fromJson(Map<String, dynamic> json) {
    return PrecautionsPModel(
      id: json['id'] as int?,
      precautions: json['precaution_name'] as String?,
    );
  }
}
