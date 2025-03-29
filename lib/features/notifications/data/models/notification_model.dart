class NotificationModel {
  final int id;
  final String title;
  final String message;

  NotificationModel(
      {required this.id, required this.title, required this.message});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      title: json["title"] ?? "No Title",
      message: json["message"] ?? "No Message",
    );
  }
}

class NotificationsResponse {
  final bool status;
  final List<NotificationModel> notifications;

  NotificationsResponse({required this.status, required this.notifications});

  factory NotificationsResponse.fromJson(Map<String, dynamic> json) {
    return NotificationsResponse(
      status: json["status"] ?? false,
      notifications: (json["data"]["data"] as List)
          .map((item) => NotificationModel.fromJson(item))
          .toList(),
    );
  }
}
