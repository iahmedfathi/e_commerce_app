class ChangePasswordModel {
  final String message;
  final bool status;

  ChangePasswordModel({required this.status, required this.message});
  factory ChangePasswordModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['message'] == null) {
      throw Exception("${'message'} is missing in the JSON response");
    }
    return ChangePasswordModel(
      message: jsonData['message'] ?? 'unknown',
      status: jsonData["status"],
    );
  }
}
