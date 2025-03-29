import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/features/notifications/data/models/notification_model.dart';
import 'package:shop_app/features/notifications/data/repo/notification_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationsState> {
  NotificationCubit(this.notificationRepo) : super(NotificationsInitial());
  NotificationCubit get(context) => BlocProvider.of(context);
  final NotificationRepo notificationRepo;
  Future<void> loadNotifications() async {
    emit(NotificationsLoading());

    final response = await notificationRepo.fetchNotifications();

    response.fold(
      (error) => emit(NotificationsError(errorMessage: error)),
      (notifications) =>
          emit(NotificationsLoaded(notifications: notifications)),
    );
  }
}
