import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shop_app/core/api/api_consumer.dart';

import 'package:shop_app/features/notifications/data/models/notification_model.dart';

class NotificationRepo {
  final ApiConsumer apiConsumer;

  NotificationRepo({required this.apiConsumer});
  Future<Either<String, List<NotificationModel>>> fetchNotifications() async {
    try {
      final response = await apiConsumer.get('notifications');
      log(response.toString(), name: "NotificationRepo");

      if (response["status"] == false) {
        return Left(response["message"] ?? "Error fetching notifications");
      }

      final notificationsResponse = NotificationsResponse.fromJson(response);
      return Right(notificationsResponse.notifications);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }
}
