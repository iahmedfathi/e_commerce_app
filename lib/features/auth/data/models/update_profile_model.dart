class UpdateProfileModel {
  final bool status;
  final String message;

  UpdateProfileModel({required this.status, required this.message});
  factory UpdateProfileModel.fromJson(Map<String, dynamic> jsonData) {
    return UpdateProfileModel(
        status: jsonData["status"], message: jsonData["message"]);
  }
}
