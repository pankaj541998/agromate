class GrowthStageCropProgramModel {
  final int id;
  final String cropName;
  final String population;
  final String cropYield;
  final String weeks;

  const GrowthStageCropProgramModel({
    required this.id,
    required this.cropName,
    required this.population,
    required this.cropYield,
    required this.weeks,
  });

  factory GrowthStageCropProgramModel.fromJson(Map<String, dynamic> json) {
    return GrowthStageCropProgramModel(
      id: json['id'],
      cropName: json['crop'],
      population: json['population'],
      cropYield: json['yield'],
      weeks: json['weeks'],
    );
  }
}
