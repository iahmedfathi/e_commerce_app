import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/widgets/get_snack_bar.dart';
import 'package:shop_app/core/widgets/text_form_field.dart';
import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfoCubit = UserInfCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.mainColor,
          ),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: AppColors.thirdColor,
        title: Text(
          'Update Profile',
          style: TextStyle(color: AppColors.mainColor),
        ),
      ),
      body: BlocConsumer<UserInfCubit, UserInfoStates>(
        listener: (context, state) {
          if (state is UpdateProfileSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(state.updateProfileModel.message,true));
            Navigator.of(context).pop();
          } else if (state is UpdateProfileFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(state.errorMessage,false));
          }
        },
        builder: (context, state) {
          userInfoCubit.updateEmailController.text =
              userInfoCubit.profileModel!.email!;
          userInfoCubit.updateUserNameController.text =
              userInfoCubit.profileModel!.name!;
          userInfoCubit.updatePhoneController.text =
              userInfoCubit.profileModel!.phone!;
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: userInfoCubit.updateProfileFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  CustomFormField(
                    controller: userInfoCubit.updateUserNameController,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.mainColor,
                    hintText: 'user name',
                    hintStyle: TextStyle(color: AppColors.mainColor),
                  ),
                  CustomFormField(
                    controller: userInfoCubit.updateEmailController,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.mainColor,
                    hintText: 'email',
                    hintStyle: TextStyle(color: AppColors.mainColor),
                  ),
                  CustomFormField(
                    controller: userInfoCubit.updatePhoneController,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.mainColor,
                    hintText: 'phone',
                    hintStyle: TextStyle(color: AppColors.mainColor),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    textColor: Colors.white,
                    color: AppColors.mainColor,
                    onPressed: () {
                      log("Updating profile with:================================================>>>>>>>>>>>.");
                      log("Name: ${userInfoCubit.updateUserNameController.text}");
                      log("Email: ${userInfoCubit.updateEmailController.text}");
                      log("Phone: ${userInfoCubit.updatePhoneController.text}");

                      userInfoCubit.updateProfile();
                    },
                    child: Text(state is UpdateProfileLoadingState
                        ? 'loading..'
                        : 'update profile'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
