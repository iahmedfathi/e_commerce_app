import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/core/utils/app_colors.dart';
import 'package:shop_app/core/utils/app_images.dart';
import 'package:shop_app/core/utils/app_router.dart';
import 'package:shop_app/core/widgets/get_snack_bar.dart';
import 'package:shop_app/core/widgets/text_field.dart';

import 'package:shop_app/features/auth/presentation/controllers/user_info_cubit.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(Assets.imagesAuthBackground),
                  fit: BoxFit.fill)),
          child: BlocConsumer<UserInfCubit, UserInfoStates>(
            listener: (context, state) {
              if (state is SignInFailureState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(getSnackBar(state.errorMessage,false));
              } else if (state is SignInSuccessState) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(getSnackBar(state.signInModel.message,true));
                context.go(
                  AppRouter.kLayoutScreen,
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: EdgeInsets.only(bottom: 40),
                      child: const Text(
                        "",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      decoration: const BoxDecoration(
                          color: AppColors.thirdColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35))),
                      child: Form(
                        key: UserInfCubit.get(context).signInFormKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: ListView(
                            children: [
                              const Center(
                                  child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold, fontSize: 19),
                              )),
                              TextFieldWidget(
                                controller: UserInfCubit.get(context)
                                    .signInEmailController,
                                hint: "Email",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFieldWidget(
                                controller: UserInfCubit.get(context)
                                    .signInPasswordController,
                                obscureText: true,
                                hint: "Password",
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              MaterialButton(
                                height: 40,
                                elevation: 0,
                                onPressed: () async {
                                  if (UserInfCubit.get(context)
                                      .signInFormKey
                                      .currentState!
                                      .validate()) {
                                    UserInfCubit.get(context).signIn();
                                  }
                                },
                                minWidth: double.infinity,
                                color: AppColors.mainColor,
                                textColor: Colors.white,
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      state is SignInLoadingState
                                          ? "Loading..."
                                          : "Sign In",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.5),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Don\'t have an account? ',
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.go(AppRouter.kSignUpScreen);
                                    },
                                    child: const Text('Create one',
                                        style: TextStyle(
                                            color: AppColors.mainColor,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
