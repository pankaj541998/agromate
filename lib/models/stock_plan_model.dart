class stockPlanModel {
  List<StockData>? data;

  stockPlanModel({this.data});

  stockPlanModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StockData>[];
      json['data'].forEach((v) {
        data!.add(new StockData.fromJson(v));
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

class StockData {
  int? id;
  int? warehouseId;
  String? startDate;
  String? stockName;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  StockData(
      {this.id,
      this.warehouseId,
      this.startDate,
      this.stockName,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  StockData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    warehouseId = json['warehouse_id'];
    startDate = json['start_date'];
    stockName = json['stock_name'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['warehouse_id'] = this.warehouseId;
    data['start_date'] = this.startDate;
    data['stock_name'] = this.stockName;
    data['quantity'] = this.quantity;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
