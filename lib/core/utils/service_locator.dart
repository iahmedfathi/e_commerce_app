import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/api/dio_consumer.dart';
import 'package:shop_app/features/auth/data/repositories/auth_repo.dart';
import 'package:shop_app/features/layout/data/repo/layout_repo.dart';
import 'package:shop_app/features/notifications/data/repo/notification_repo.dart';

// Create an instance of GetIt
final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingleton<DioConsumer>(DioConsumer(dio: Dio()));
  // Register API Consumer
  locator.registerSingleton<ApiConsumer>(locator.get<DioConsumer>());

  // Register Auth Repository
  locator.registerSingleton<UserRepo>(
      UserRepo(apiConsumer: locator.get<ApiConsumer>()));
  locator.registerSingleton<LayoutRepo>(
      LayoutRepo(apiConsumer: locator.get<ApiConsumer>()));
  locator.registerSingleton<NotificationRepo>(
      NotificationRepo(apiConsumer: locator.get<ApiConsumer>()));

  // Register Auth Cubit
}
