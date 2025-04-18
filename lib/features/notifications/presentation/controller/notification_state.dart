part of 'notification_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  NotificationsLoaded({required this.notifications});
}

class NotificationsError extends NotificationsState {
  final String errorMessage;
  NotificationsError({required this.errorMessage});
}
