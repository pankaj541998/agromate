class CropPModel {
  final int? id;
  final String? crop;
  final String? plantPopulation;
  final String? yeild;
  final String? weeks;

  const CropPModel({
    required this.id,
    required this.crop,
    required this.plantPopulation,
    required this.yeild,
    required this.weeks,
  });

  factory CropPModel.fromJson(Map<String, dynamic> json) {
    return CropPModel(
      id: json['id'] as int?,
      crop: json['crop'] as String?,
      plantPopulation: json['population'] as String?,
      yeild: json['yield'] as String?,
      weeks: json['weeks'] as String?,
    );
  }
}
