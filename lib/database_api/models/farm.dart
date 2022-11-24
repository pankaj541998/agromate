class FarmModel {
  final int? id;
  final int? landholderId;
  final String? farmName;
  final String? farmLatLngs;

  const FarmModel({
    required this.id,
    required this.landholderId,
    required this.farmName,
    required this.farmLatLngs,
  });

  factory FarmModel.fromJson(Map<String, dynamic> json) {
    return FarmModel(
      id: json['id'] as int?,
      landholderId: json['landholder_id'] as int?,
      farmName: json['farm'] as String?,
      farmLatLngs: json['farm_latlong'] as String?,
    );
  }
}