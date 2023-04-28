class TypePModel {
  final int? id;
  final String? type;

  const TypePModel({
    required this.id,
    required this.type,
  });

  factory TypePModel.fromJson(Map<String, dynamic> json) {
    return TypePModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
    );
  }
}
