import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/api/end_pointes.dart';
import 'package:shop_app/core/cache/cache_helper.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_router.dart';
import 'package:shop_app/core/utils/service_locator.dart';
import 'package:shop_app/features/auth/data/repositories/auth_repo.dart';
import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';
import 'package:shop_app/features/layout/data/repo/layout_repo.dart';
import 'package:shop_app/features/layout/presentation/controllers/cubit/layout_cubit.dart';
import 'package:shop_app/features/notifications/data/repo/notification_repo.dart';
import 'package:shop_app/features/notifications/presentation/controller/notification_cubit.dart';

void main() async {
  Stripe.publishableKey = ApiKey.publishableKey;
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();
  await CacheHelper().init();
  token = await CacheHelper.getData(key: "token");
  currentPassword = await CacheHelper.getData(key: "password");

  final layoutCubit = LayoutCubit(locator.get<LayoutRepo>());
  final userInfoCubit = UserInfCubit(userRepo: locator.get<UserRepo>());
  final notificationCubit = NotificationCubit(locator.get<NotificationRepo>());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => notificationCubit..loadNotifications()),
        BlocProvider(create: (context) => userInfoCubit),
        BlocProvider(
          create: (context) => layoutCubit
            ..getFavoriteProducts()
            ..getBannersData()
            ..getCategoriesData()
            ..getProducts()
            ..getCart(),
        ),
      ],
      child: const ShopApp(),
    ),
  );
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(appBarTheme: AppBarTheme(color: AppColors.thirdColor,iconTheme: IconThemeData(color: AppColors.mainColor))),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
