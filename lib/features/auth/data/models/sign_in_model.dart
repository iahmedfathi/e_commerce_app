class SignInModel {
  final bool status;
  final String message;

  SignInModel({required this.status, required this.message});
  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
        status: jsonData["status"], message: jsonData["message"]);
  }
}
