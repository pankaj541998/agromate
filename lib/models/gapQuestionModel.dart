class GapQuestion {
  final int? gapCategoryId;
  final String? question;
  final int? options;
  final int? text;
  final int? image;

  GapQuestion(
      {required this.gapCategoryId,
      required this.question,
      required this.options,
      required this.text,
      required this.image});

  factory GapQuestion.fromJson(Map<String, dynamic> json) {
    return GapQuestion(
      gapCategoryId: json['gap_category_id'] as int?,
      question: json['question'] as String?,
      options: json['options'] as int?,
      text: json['text'] as int?,
      image: json['image'] as int?,
    );
  }
}
