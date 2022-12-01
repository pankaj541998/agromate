class GrowthStageModel {
  final int id;
  final int cropProgramId;
  final String growthName;
  final String description;
  final String startWeek;
  final String endWeek;

  const GrowthStageModel({
    required this.id,
    required this.cropProgramId,
    required this.growthName,
    required this.description,
    required this.startWeek,
    required this.endWeek,
  });

  factory GrowthStageModel.fromJson(Map<String, dynamic> json) {
    return GrowthStageModel(
      id: json['id'] as int,
      cropProgramId: json['crop_program_id'] as int,
      growthName: json['growth_name'] as String,
      description: json['description'] as String,
      startWeek: json['start_week'] as String,
      endWeek: json['end_week'] as String,
    );
  }
}
