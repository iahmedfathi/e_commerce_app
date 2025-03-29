import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/features/layout/data/models/banner_model/banner_model.dart';
import 'package:shop_app/features/layout/data/models/categories_details_model/categories_details_model.dart';
import 'package:shop_app/features/layout/data/models/categories_model/categories_model.dart';
import 'package:shop_app/features/layout/data/models/product_model.dart';
import 'package:shop_app/features/layout/data/repo/layout_repo.dart';
import 'package:shop_app/features/layout/presentation/views/screens/profile_screen.dart';
import 'package:shop_app/features/checkout/presentation/views/cart_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/categories_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/favorites_screen.dart';
import 'package:shop_app/features/layout/presentation/views/screens/home_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(this.layoutRepo) : super(LayoutInitial());
  final LayoutRepo layoutRepo;
  static LayoutCubit get(context) => BlocProvider.of(context);
  List<BannerModel> bannerModels = [];
  List<CategoriesModel> categories = [];
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  List<ProductModel> favoriteProducts = [];
  ProductModel? productDetails;
  Set<String> productsId = {};
  Set<String> cartId = {};

  List<ProductModel> cartProducts = [];
  int totalPrice = 0;

  int currentIndex = 0;
  void setCurrentIndex({required int index}) {
    currentIndex = index;
    emit(NavigationBarIndexState());
  }

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    CartScreen(),
    ProfileScreen(),
   
  ];

  Future<void> getBannersData() async {
    emit(BannerLoadingState());
    final response = await layoutRepo.getBannersData(path: "banners");
    response.fold(
      (error) {
        emit(BannerFailureState(errorMessage: error));
      },
      (bannersModels) {
        bannerModels = bannersModels;
        emit(BannerSuccessState(bannerModels: bannerModels));
      },
    );
  }

  Future<void> getCategoriesData() async {
    emit(CategoriesLoadingState());
    final response = await layoutRepo.getCategoriesData(path: "categories");
    response.fold(
      (error) {
        emit(CategoriesFailureState(errorMessage: error));
      },
      (categoriesModel) {
        categories = categoriesModel;
        emit(CategoriesSuccessState(categoriesModels: categories));
      },
    );
  }

  Future<void> getCategoriesDetails({required int categoriesId}) async {
    emit(CategoriesDetailsLoadingState());
    final response =
        await layoutRepo.getCategoriesDetails(path: "categories/$categoriesId");
    response.fold(
      (error) {
        emit(CategoriesDetailsFailureState(errorMessage: error));
      },
      (categoriesDetailsModels) {
        emit(CategoriesDetailsSuccessState(
            categoriesDetailsModels: categoriesDetailsModels));
      },
    );
  }

  Future<void> getProducts() async {
    emit(ProductsLoadingState());

    final response = await layoutRepo.getProducts(path: "home");
    response.fold(
      (error) {
        log("Products fetch failed: $error");
        emit(ProductsFailureState(errorMessage: error));
      },
      (productsModel) {
        products = productsModel;
        log("Fetched ${products.length} products");
        emit(ProductsSuccessState(products: products));
      },
    );
  }

  Future<void> getProductsDetails({required int productId}) async {
    emit(ProductDetailsLoading());

    final response =
        await layoutRepo.getProductDetails(path: "products/$productId");
    response.fold(
      (error) {
        log("Products fetch failed: $error");
        emit(ProductDetailsFailure(errorMessage: error));
      },
      (productsDetailsModel) {
        productDetails = productsDetailsModel;
        log("Fetched ${products.length} products");
        emit(ProductDetailsSuccess(product: productsDetailsModel));
      },
    );
  }

  void filterProductsByName(String query) {
    filteredProducts = products
        .where((product) =>
            product.name!.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    emit(UpdateProductsSuccessState());
  }

  Future<void> getFavoriteProducts() async {
    emit(FavProductsLoadingState());
    final response = await layoutRepo.getFavoriteProducts(path: "favorites");
    response.fold((error) => emit(FavProductsFailureState(errorMessage: error)),
        (favProducts) {
      productsId = layoutRepo.favoritesId;
      favoriteProducts = favProducts;
      emit(FavProductsSuccessState(favProducts: favProducts));
    });
  }

  Future<void> addOrDelateFavProduct({required String productId}) async {
    final response = await layoutRepo.addOrDeleteFavProduct(
        path: "favorites", productId: productId);
    response.fold(
        (error) => emit(AddOrDelateFavProductFailure(errorMessage: error)),
        (_) async {
      productsId = layoutRepo.getFavoritesId();
      await getFavoriteProducts();
      emit(AddOrDelateFavProductSuccess());
    });
  }

  Future<void> getCart() async {
    emit(FavProductsLoadingState());
    final response = await layoutRepo.getCarts(path: "carts");
    response.fold((error) => emit(GetCartFailure(errorMessage: error)), (cart) {
      totalPrice = layoutRepo.totalPrice.toInt();
      cartProducts = cart;
      emit(GetCartSuccess(cartProducts: cart));
    });
  }

  Future<void> addOrDelateFromCart({required String productId}) async {
    final response = await layoutRepo.addOrDeleteFromCart(
        path: "carts", productId: productId);
    response
        .fold((error) => emit(AddOrDelateFromCartFailure(errorMessage: error)),
            (_) async {
      cartId = layoutRepo.getCartsId();
      await getCart();
      emit(AddOrDelateFromCartSuccess());
    });
  }
}
