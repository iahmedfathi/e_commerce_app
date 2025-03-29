import 'package:dartz/dartz.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/cache/cache_helper.dart';
import 'package:shop_app/core/errors/exceptions.dart';
import 'package:shop_app/features/auth/data/models/change_password_model.dart';
import 'package:shop_app/features/auth/data/models/profile_model.dart';
import 'package:shop_app/features/auth/data/models/sign_in_model.dart';
import 'package:shop_app/features/auth/data/models/sign_up_model.dart';
import 'package:shop_app/features/auth/data/models/update_profile_model.dart';

class UserRepo {
  final ApiConsumer apiConsumer;
  ProfileModel? profileModel;
  ChangePasswordModel? changePasswordModel;

  UserRepo({required this.apiConsumer});
  Future<Either<String, SignUpModel>> sinUp(
      {required String path,
      required String name,
      required String email,
      required String password,
      required String phone,
      required String image}) async {
    try {
      final response = await apiConsumer.post(path, data: {
        'name': name,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
      });
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      final signUpModel = SignUpModel.fromJson(response);
      return Right(signUpModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, SignInModel>> signIn({
    required String path,
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiConsumer.post(path, data: {
        "email": email,
        "password": password,
      });
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      await CacheHelper.put(key: "token", value: response['data']["token"]);
      token = await CacheHelper.getData(key: "token");
      final signInModel = SignInModel.fromJson(response);
      await CacheHelper.put(key: "password", value: password);
      currentPassword = await CacheHelper.getData(key: "password");
      return Right(signInModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, ProfileModel>> getProfile({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(
        path,
      );
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      final profileModel = ProfileModel.fromJson(response["data"]);
      return Right(profileModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, ChangePasswordModel>> changePassword({
    required String path,
    required String newPassword,
    required String userCurrentPassword,
  }) async {
    try {
      final response = await apiConsumer.post(path, data: {
        "new_password": newPassword,
        "current_password": userCurrentPassword,
      });
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      final changePasswordModel = ChangePasswordModel.fromJson(response);
      await CacheHelper.put(key: "password", value: newPassword);
      currentPassword = await CacheHelper.getData(key: "password");
      return Right(changePasswordModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, UpdateProfileModel>> updateProfile({
    required String path,
    required String name,
    required String emailAddress,
    required String phone,
  }) async {
    try {
      final response = await apiConsumer.put(path, data: {
        "name": name,
        "email": emailAddress,
        "phone": phone,
      });
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      final updateProfileModel = UpdateProfileModel.fromJson(response);
      return Right(updateProfileModel);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }
}
