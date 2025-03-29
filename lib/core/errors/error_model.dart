class ErrorModel {
  final bool? status;
  final String errorMessage;

  ErrorModel({this.status, required this.errorMessage});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData["status"],
      errorMessage: jsonData["message"],
    );
  }
}
