import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/widgets/get_snack_bar.dart';
import 'package:shop_app/core/widgets/text_form_field.dart';
import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

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
          'Change Password',
          style: TextStyle(color: AppColors.mainColor),
        ),
      ),
      body: BlocConsumer<UserInfCubit, UserInfoStates>(
        listener: (context, state) {
          if (state is ChangePasswordSuccessState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(state.changePasswordModel.message,true));
            Navigator.of(context).pop();
          } else if (state is ChangePasswordFailureState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(getSnackBar(state.errorMessage,false));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: userInfoCubit.changePasswordFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  CustomFormField(
                    controller: userInfoCubit.currentPasswordController,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.mainColor,
                    hintText: 'current Password',
                    hintStyle: TextStyle(color: AppColors.mainColor),
                  ),
                  CustomFormField(
                    controller: userInfoCubit.newPasswordController,
                    textAlign: TextAlign.center,
                    cursorColor: AppColors.mainColor,
                    hintText: 'new Password',
                    hintStyle: TextStyle(color: AppColors.mainColor),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    textColor: Colors.white,
                    color: AppColors.mainColor,
                    onPressed: () {
                      if (userInfoCubit.changePasswordFormKey.currentState!
                          .validate()) {
                        userInfoCubit.changePasswordFormKey.currentState!
                            .save();
                        if (userInfoCubit.currentPasswordController.text
                                .trim() ==
                            currentPassword) {
                          if (userInfoCubit.newPasswordController.text.length >=
                              6) {
                            userInfoCubit.changePassword();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                getSnackBar(
                                    'Password must be at least 6 characters',false));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              getSnackBar('Current Password is not correct',false));
                        }
                      }
                    },
                    child: Text(state is ChangePasswordLoadingState
                        ? 'loading..'
                        : 'Change Password'),
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
