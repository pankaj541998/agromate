class StockPlanModel {
  List<StockPlanData>? data;

  StockPlanModel({this.data});

  StockPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StockPlanData>[];
      json['data'].forEach((v) {
        data!.add(new StockPlanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StockPlanData {
  int? id;
  int? warehouseId;
  String? endDate;
  String? stockName;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  StockPlanData(
      {this.id,
      this.warehouseId,
      this.endDate,
      this.stockName,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  StockPlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseId = json['warehouse_id'];
    endDate = json['end_date'];
    stockName = json['stock_name'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_id'] = this.warehouseId;
    data['end_date'] = this.endDate;
    data['stock_name'] = this.stockName;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
