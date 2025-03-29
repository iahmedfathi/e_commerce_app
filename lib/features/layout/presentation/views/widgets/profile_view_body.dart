import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_router.dart';

import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfCubit, UserInfoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final userInfoCubit = UserInfCubit.get(context);
        if (userInfoCubit.profileModel == null) {
          userInfoCubit.profileInfo();
        }
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(24),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    "https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-male-user-profile-vector-illustration-isolated-background-man-profile-sign-business-concept_157943-38764.jpg?semt=ais_hybrid"),
              ),
              Text(
                userInfoCubit.profileModel?.name ?? '',
                style: TextStyle(color: AppColors.mainColor),
              ),
              Text(
                userInfoCubit.profileModel?.email ?? '',
                style: TextStyle(color: AppColors.mainColor),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                color: AppColors.mainColor,
                onPressed: () {
                  context.push(AppRouter.kChangePasswordScreen);
                },
                child: Text('change password'),
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                color: AppColors.mainColor,
                onPressed: () {
                  context.push(AppRouter.kUpdateProfileScreen);
                },
                child: Text('update profile'),
              ),
            ],
          ),
        );
      },
    );
  }
}
