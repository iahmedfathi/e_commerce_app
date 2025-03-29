import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/features/auth/data/models/change_password_model.dart';
import 'package:shop_app/features/auth/data/models/profile_model.dart';
import 'package:shop_app/features/auth/data/models/sign_in_model.dart';
import 'package:shop_app/features/auth/data/models/sign_up_model.dart';
import 'package:shop_app/features/auth/data/models/update_profile_model.dart';
import 'package:shop_app/features/auth/data/repositories/auth_repo.dart';

part 'user_info_states.dart';

class UserInfCubit extends Cubit<UserInfoStates> {
  UserInfCubit({
    required this.userRepo,
  }) : super(AuthInitial());
  final UserRepo userRepo;
  static UserInfCubit get(context) => BlocProvider.of(context);

  TextEditingController signUpNameController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController signUpPhoneController = TextEditingController();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateUserNameController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  GlobalKey<FormState> signInFormKey = GlobalKey();
  GlobalKey<FormState> changePasswordFormKey = GlobalKey();
  GlobalKey<FormState> updateProfileFormKey = GlobalKey();
  ProfileModel? profileModel;
  Future<void> signUp() async {
    emit(SignupLoadingState());
    final response = await userRepo.sinUp(
        path: "register",
        email: signUpEmailController.text,
        name: signUpNameController.text,
        password: signUpPasswordController.text,
        phone: signUpPhoneController.text,
        image: 'jjjjj');

    response.fold((error) => emit(SignUpFailureState(errorMessage: error)),
        (signUpModel) => emit(SignupSuccessState(signUpModel: signUpModel)));
  }

  Future<void> signIn() async {
    emit(SignInLoadingState());
    final response = await userRepo.signIn(
      path: "login",
      email: signInEmailController.text,
      password: signInPasswordController.text,
    );

    response.fold((error) => emit(SignInFailureState(errorMessage: error)),
        (signInModel) => emit(SignInSuccessState(signInModel: signInModel)));
  }

  Future<void> profileInfo() async {
    emit(ProfileInfoLoadingState());
    final response = await userRepo.getProfile(path: 'profile');

    response.fold((error) => emit(ProfileInfoFailureState(errorMessage: error)),
        (profileInfo) {
      profileModel = profileInfo;
      return emit(ProfileInfoISuccessState(profileModel: profileInfo));
    });
  }

  Future<void> changePassword() async {
    emit(ChangePasswordLoadingState());
    final response = await userRepo.changePassword(
        path: 'change-password',
        userCurrentPassword: currentPassword!,
        newPassword: newPasswordController.text);

    response
        .fold((error) => emit(ChangePasswordFailureState(errorMessage: error)),
            (changePasswordModel) {
      return emit(
          ChangePasswordSuccessState(changePasswordModel: changePasswordModel));
    });
  }

  Future<void> updateProfile() async {
    emit(UpdateProfileLoadingState());
    final response = await userRepo.updateProfile(
        path: 'update-profile',
        emailAddress: updateEmailController.text,
        name: updateUserNameController.text,
        phone: updatePhoneController.text);

    response
        .fold((error) => emit(UpdateProfileFailureState(errorMessage: error)),
            (updateModel) async {
      await profileInfo();
      return emit(UpdateProfileSuccessState(updateProfileModel: updateModel));
    });
  }
}
