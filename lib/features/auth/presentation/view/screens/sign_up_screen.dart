import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_router.dart';

import 'package:shop_app/core/widgets/get_snack_bar.dart';
import 'package:shop_app/core/widgets/text_field.dart';
import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserInfCubit, UserInfoStates>(
      listener: (context, state) {
        if (state is SignUpFailureState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.errorMessage,false));
        } else if (state is SignupSuccessState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(getSnackBar(state.signUpModel.message,true));
          context.go(AppRouter.kHomeScreen);
        }
      },
      builder: (context, state) {
        final signUp = UserInfCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const Text(""),
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: signUp.signUpFormKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 22.5, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFieldWidget(
                            hint: "User Name",
                            controller: signUp.signUpNameController),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            hint: "Email",
                            controller: signUp.signUpEmailController),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            hint: "Phone",
                            controller: signUp.signUpPhoneController),
                        SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                            hint: "Password",
                            controller: signUp.signUpPasswordController),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          minWidth: double.infinity,
                          elevation: 0,
                          height: 40,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          color: AppColors.mainColor,
                          onPressed: () {
                            if (signUp.signUpFormKey.currentState!.validate()) {
                              signUp.signUp();
                            }
                          },
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                state is SignupLoadingState
                                    ? "Loading..."
                                    : "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.5,
                                    color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? ',
                                style: TextStyle(color: Colors.black)),
                            SizedBox(
                              width: 4,
                            ),
                            InkWell(
                              onTap: () {
                                context.go(AppRouter.kSignInScreen);
                              },
                              child: const Text('sign in',
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )),
          ),
        );
      },
    );
  }
}
