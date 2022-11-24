// ignore_for_file: file_names

class ModeModel {
  final int id;
  final String mode;

  const ModeModel({
    required this.id,
    required this.mode,
  });

  factory ModeModel.fromJson(Map<String, dynamic> json) {
    return ModeModel(
      id: json['id'] as int,
      mode: json['mode'] as String,
    );
  }
}

// class ModeModel {
//   List<Data>? data;

//   ModeModel({this.data});

//   ModeModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? mode;
//   String? createdAt;
//   String? updatedAt;

//   Data({this.id, this.mode, this.createdAt, this.updatedAt});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mode = json['mode'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['mode'] = this.mode;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
