part of 'user_info_cubit.dart';

abstract class UserInfoStates {}

class AuthInitial extends UserInfoStates {}

class SignupLoadingState extends UserInfoStates {}

class SignupSuccessState extends UserInfoStates {
  final SignUpModel signUpModel;

  SignupSuccessState({required this.signUpModel});
}

class SignUpFailureState extends UserInfoStates {
  final String errorMessage;

  SignUpFailureState({required this.errorMessage});
}

class SignInLoadingState extends UserInfoStates {}

class SignInSuccessState extends UserInfoStates {
  final SignInModel signInModel;

  SignInSuccessState({required this.signInModel});
}

class SignInFailureState extends UserInfoStates {
  final String errorMessage;

  SignInFailureState({required this.errorMessage});
}

class ProfileInfoLoadingState extends UserInfoStates {}

class ProfileInfoISuccessState extends UserInfoStates {
  final ProfileModel profileModel;

  ProfileInfoISuccessState({required this.profileModel});
}

class ProfileInfoFailureState extends UserInfoStates {
  final String errorMessage;

  ProfileInfoFailureState({required this.errorMessage});
}

class ChangePasswordLoadingState extends UserInfoStates {}

class ChangePasswordSuccessState extends UserInfoStates {
  final ChangePasswordModel changePasswordModel;

  ChangePasswordSuccessState({required this.changePasswordModel});
}

class ChangePasswordFailureState extends UserInfoStates {
  final String errorMessage;

  ChangePasswordFailureState({required this.errorMessage});
}

class UpdateProfileLoadingState extends UserInfoStates {}

class UpdateProfileSuccessState extends UserInfoStates {
  final UpdateProfileModel updateProfileModel;

  UpdateProfileSuccessState({required this.updateProfileModel});
}

class UpdateProfileFailureState extends UserInfoStates {
  final String errorMessage;

  UpdateProfileFailureState({required this.errorMessage});
}
