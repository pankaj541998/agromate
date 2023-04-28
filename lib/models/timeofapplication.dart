class TimeOFApplicationPModel {
  final int? id;
  final String? timeOFApplication;

  const TimeOFApplicationPModel({
    required this.id,
    required this.timeOFApplication,
  });

  factory TimeOFApplicationPModel.fromJson(Map<String, dynamic> json) {
    return TimeOFApplicationPModel(
      id: json['id'] as int?,
      timeOFApplication: json['time_of_application_name'] as String?,
    );
  }
}
