class KeyTargetsPModel {
  final int? id;
  final String? keyTargets;

  const KeyTargetsPModel({
    required this.id,
    required this.keyTargets,
  });

  factory KeyTargetsPModel.fromJson(Map<String, dynamic> json) {
    return KeyTargetsPModel(
      id: json['id'] as int?,
      keyTargets: json['key_target_name'] as String?,
    );
  }
}
