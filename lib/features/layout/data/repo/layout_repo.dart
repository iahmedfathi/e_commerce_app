import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:shop_app/core/api/api_consumer.dart';
import 'package:shop_app/core/errors/exceptions.dart';
import 'package:shop_app/features/layout/data/models/banner_model/banner_model.dart';
import 'package:shop_app/features/layout/data/models/categories_details_model/categories_details_model.dart';
import 'package:shop_app/features/layout/data/models/categories_model/categories_model.dart';
import 'package:shop_app/features/layout/data/models/product_model.dart';

class LayoutRepo {
  final ApiConsumer apiConsumer;

  LayoutRepo({required this.apiConsumer});
  Set<String> favoritesId = {};
  Set<String> cartId = {};
  Set<String> getCartsId() => cartId;
  num totalPrice = 0;
  num getTotalPrice() => totalPrice;
  Set<String> getFavoritesId() => favoritesId;
  Future<Either<String, List<BannerModel>>> getBannersData({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);

      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      if (response["data"] == null || response["data"] is! List) {
        return Left("Invalid banner data received");
      }
      final List<BannerModel> bannerModels = (response["data"] as List)
          .map((item) => BannerModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(bannerModels);
    } on ServerException catch (e) {
      log("Server exception: ${e.errModel.errorMessage}");
      return Left(e.errModel.errorMessage);
    } catch (e) {
      log("Unexpected error: $e");
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, List<CategoriesModel>>> getCategoriesData({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      if (response["data"]["data"] == null ||
          response["data"]["data"] is! List) {
        return Left("Invalid banner data received");
      }

      final List<CategoriesModel> categoriesModels = (response["data"]["data"]
              as List)
          .map((item) => CategoriesModel.fromJson(item as Map<String, dynamic>))
          .toList();

      return Right(categoriesModels);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, List<CategoriesDetailsModel>>> getCategoriesDetails({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      if (response["data"]["data"] == null ||
          response["data"]["data"] is! List) {
        return Left("Invalid banner data received");
      }

      final List<CategoriesDetailsModel> categoriesDetailsModels =
          (response["data"]["data"] as List)
              .map((item) =>
                  CategoriesDetailsModel.fromJson(item as Map<String, dynamic>))
              .toList();

      return Right(categoriesDetailsModels);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    } catch (e) {
      return Left("An unexpected error occurred: $e");
    }
  }

  Future<Either<String, List<ProductModel>>> getProducts({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      if (response["data"]["products"] == null ||
          response["data"]["products"] is! List) {
        return Left("Invalid banner data received");
      }
      final List<ProductModel> products = (response["data"]["products"] as List)
          .map((product) =>
              ProductModel.fromJson(product as Map<String, dynamic>))
          .toList();
      return Right(products);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, ProductModel>> getProductDetails({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }

      final ProductModel product =
          ProductModel.fromJson(response["data"] as Map<String, dynamic>);
      return Right(product);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, List<ProductModel>>> getFavoriteProducts(
      {required String path}) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? 'an error happened ');
      }
      final List<ProductModel> favoriteProducts =
          (response["data"]["data"] as List).map((product) {
        final productData = product["product"] as Map<String, dynamic>;
        favoritesId.add(productData["id"].toString());
        return ProductModel.fromJson(productData);
      }).toList();
      return Right(favoriteProducts);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, void>> addOrDeleteFavProduct(
      {required String path, required String productId}) async {
    try {
      final response = await apiConsumer.post(
        path,
        data: {"product_id": productId},
      );
      if (response["status"] == false) {
        return Left(response["message"] ?? 'an error happened ');
      }
      if (favoritesId.contains(productId)) {
        favoritesId.remove(productId);
      } else {
        favoritesId.add(productId);
      }
      await getFavoriteProducts(path: "favorites");

      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, List<ProductModel>>> getCarts({
    required String path,
  }) async {
    try {
      final response = await apiConsumer.get(path);
      if (response["status"] == false) {
        return Left(response["message"] ?? "An error occurred");
      }
      final List<ProductModel> carts =
          (response["data"]["cart_items"] as List).map((product) {
        final productData = product["product"] as Map<String, dynamic>;
        totalPrice = response["data"]["total"];
        return ProductModel.fromJson(productData);
      }).toList();
      log(carts.length.toString());
      return Right(carts);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }

  Future<Either<String, void>> addOrDeleteFromCart(
      {required String path, required String productId}) async {
    try {
      final response = await apiConsumer.post(
        path,
        data: {"product_id": productId},
      );
      if (response["status"] == false) {
        return Left(response["message"] ?? 'an error happened ');
      }
      if (cartId.contains(productId)) {
        cartId.remove(productId);
      } else {
        cartId.add(productId);
      }
      await getCarts(path: "carts");

      return Right(null);
    } on ServerException catch (e) {
      return Left(e.errModel.errorMessage);
    }
  }
}
