// ignore_for_file: file_names

class ClassModel {
  final int? id;
  final String? className;

  const ClassModel({
    required this.id,
    required this.className,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as int?,
      className: json['iclass'] as String?,
    );
  }
}
