class CropPlanModel {
  final int? id;
  final int? landholderId;
  final int? farmId;
  final int? blockId;
  final int? fieldId;
  final int? cropId;
  final int? farmerId;
  final String? hectarage;
  final String? planneddate;
  final int? stageId;
  final int? isActive;
  final int? isDelete;

  CropPlanModel({
    required this.id,
    required this.landholderId,
    required this.farmId,
    required this.blockId,
    required this.fieldId,
    required this.cropId,
    required this.farmerId,
    required this.hectarage,
    required this.planneddate,
    required this.stageId,
    required this.isActive,
    required this.isDelete,
  });

  factory CropPlanModel.fromJson(Map<String, dynamic> json) {
    return CropPlanModel(
      id: json['id'] as int?,
      landholderId: json['landholder_id'] as int?,
      farmId: json['farm_id'] as int?,
      blockId: json['block_id'] as int?,
      fieldId: json['field_id'] as int?,
      cropId: json['crop_id'] as int?,
      farmerId: json['farmer_id'] as int?,
      hectarage: json['hectarage'] as String?,
      planneddate: json['planneddate'] as String?,
      stageId: json['stage_id'] as int?,
      isActive: json['is_active'] as int?,
      isDelete: json['is_delete'] as int?,
    );
  }
}
