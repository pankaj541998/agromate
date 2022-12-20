class GapQuestionListModel {
  final int? id;
  final String? gapCategory;

  GapQuestionListModel({
    required this.id,
    required this.gapCategory,
  });

  factory GapQuestionListModel.fromJson(Map<String, dynamic> json) {
    return GapQuestionListModel(
      id: json['id'] as int?,
      gapCategory: json['gap_category'] as String?,
    );
  }
}
