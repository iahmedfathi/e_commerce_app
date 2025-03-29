import 'package:dio/dio.dart';

import 'package:shop_app/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
     throw ServerException(
    errModel: e.response != null 
      ? ErrorModel.fromJson(e.response!.data) 
      : ErrorModel(errorMessage: "Connection timed out, please try again.")
  );
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw throw ServerException(
          errModel: ErrorModel(
        errorMessage:
            "No internet connection. Please check your network and try again.",
      ));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400:
          case 401:
          case 403:
          case 404:
          case 405:
          case 409:
          case 422:
          case 504:
            throw ServerException(
                errModel: ErrorModel.fromJson(e.response!.data));
        }
      }
      throw ServerException(
        errModel: ErrorModel(
          errorMessage: "An unexpected server error occurred.",
        ),
      );
  }
}
