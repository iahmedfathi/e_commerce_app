import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_images.dart';
import 'package:shop_app/core/widgets/custom_loading_indicator.dart';
import 'package:shop_app/features/notifications/presentation/controller/notification_cubit.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        } 
      },
      builder: (context, state) {
        if (state is NotificationsLoading) {
          return CustomLoadingAnimation();
        } else if (state is NotificationsLoaded) {
          return Scaffold(
              appBar: AppBar(
                  backgroundColor: AppColors.thirdColor,
                  title: SvgPicture.asset(
                    Assets.imagesLogo,
                    height: 40,
                    width: 40,
                  )),
              body: SafeArea(
                child: ListView.builder(
                  itemCount: state.notifications.length,
                  itemBuilder: (context, index) {
                    final notification = state.notifications[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: AppColors.mainColor,
                        child: ListTile(
                          title: Text(
                            notification.title,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            notification.message,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
        } else {
          return Center(child: Text("No notifications available"));
        }
      },
    );
  }
}
