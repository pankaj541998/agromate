
class FieldModel {
  final int? id;
  final int? landholderId;
  final int? farmId;
  final int? blockId;
  final String? fieldName;
  final String? fieldLatLngs;

  const FieldModel({
    required this.id,
    required this.landholderId,
    required this.farmId,
    required this.blockId,
    required this.fieldName,
    required this.fieldLatLngs,
  });

  factory FieldModel.fromJson(Map<String, dynamic> json) {
    return FieldModel(
      id: json['id'] as int?,
      landholderId: json['landholder_id'] as int?,
      farmId: json['farm_id'] as int?,
      blockId: json['block_id'] as int?,
      fieldName: json['field'] as String?,
      fieldLatLngs: json['field_latlong'] as String?,
    );
  }
}