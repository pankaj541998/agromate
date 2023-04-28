class InstructionsPModel {
  final int? id;
  final String? instructions;

  const InstructionsPModel({
    required this.id,
    required this.instructions,
  });

  factory InstructionsPModel.fromJson(Map<String, dynamic> json) {
    return InstructionsPModel(
      id: json['id'] as int?,
      instructions: json['instruction_name'] as String?,
    );
  }
}
