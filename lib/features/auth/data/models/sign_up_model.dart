class SignUpModel {
  final String message;
  final bool status;

  SignUpModel({required this.status, required this.message});
  factory SignUpModel.fromJson(Map<String, dynamic> jsonData) {
    if (jsonData['message'] == null) {
      throw Exception("${'message'} is missing in the JSON response");
    }
    return SignUpModel(
      message: jsonData['message'] ?? 'unknown',
      status: jsonData["status"],
    );
  }
}
