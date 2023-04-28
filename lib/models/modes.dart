class ModesPModel {
  final int? id;
  final String? modes;

  const ModesPModel({
    required this.id,
    required this.modes,
  });

  factory ModesPModel.fromJson(Map<String, dynamic> json) {
    return ModesPModel(
      id: json['id'] as int?,
      modes: json['mode'] as String?,
    );
  }
}
