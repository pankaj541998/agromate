class CategoryPModel {
  final int? id;
  final String? iclass;

  const CategoryPModel({
    required this.id,
    required this.iclass,
  });

  factory CategoryPModel.fromJson(Map<String, dynamic> json) {
    return CategoryPModel(
      id: json['id'] as int?,
      iclass: json['iclass'] as String?,
    );
  }
}
