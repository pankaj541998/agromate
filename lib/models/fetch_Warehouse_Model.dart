class fetchWarehouse {
  int? id;
  String? warehouseName;
  int? isActive;
  Null? createdAt;
  Null? updatedAt;

  fetchWarehouse(
      {this.id,
      this.warehouseName,
      this.isActive,
      this.createdAt,
      this.updatedAt});

  fetchWarehouse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseName = json['warehouse_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_name'] = this.warehouseName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
