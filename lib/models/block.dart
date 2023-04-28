class BlockModel {
  final int? id;
  final int? landholderId;
  final int? farmId;
  final String? blockName;
  final String? blockLatLngs;

  const BlockModel({
    required this.id,
    required this.landholderId,
    required this.farmId,
    required this.blockName,
    required this.blockLatLngs,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      id: json['id'] as int?,
      landholderId: json['landholder_id'] as int?,
      farmId: json['farm_id'] as int?,
      blockName: json['block'] as String?,
      blockLatLngs: json['block_latlong'] as String?,
    );
  }
}
