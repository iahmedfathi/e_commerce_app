part of 'layout_cubit.dart';

abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class NavigationBarIndexState extends LayoutState {}

class BannerLoadingState extends LayoutState {}

class BannerSuccessState extends LayoutState {
  final List<BannerModel> bannerModels;

  BannerSuccessState({required this.bannerModels});
}

class BannerFailureState extends LayoutState {
  final String errorMessage;

  BannerFailureState({required this.errorMessage});
}

class CategoriesLoadingState extends LayoutState {}

class CategoriesSuccessState extends LayoutState {
  final List<CategoriesModel> categoriesModels;

  CategoriesSuccessState({required this.categoriesModels});
}

class CategoriesFailureState extends LayoutState {
  final String errorMessage;

  CategoriesFailureState({required this.errorMessage});
}

class CategoriesDetailsLoadingState extends LayoutState {}

class CategoriesDetailsSuccessState extends LayoutState {
  final List<CategoriesDetailsModel> categoriesDetailsModels;

  CategoriesDetailsSuccessState({required this.categoriesDetailsModels});
}

class CategoriesDetailsFailureState extends LayoutState {
  final String errorMessage;

  CategoriesDetailsFailureState({required this.errorMessage});
}

class ProductsLoadingState extends LayoutState {}

class ProductsSuccessState extends LayoutState {
  final List<ProductModel> products;

  ProductsSuccessState({required this.products});
}

class ProductsFailureState extends LayoutState {
  final String errorMessage;

  ProductsFailureState({required this.errorMessage});
}

class ProductDetailsLoading extends LayoutState {}

class ProductDetailsSuccess extends LayoutState {
  final ProductModel product;

  ProductDetailsSuccess({required this.product});
}

class ProductDetailsFailure extends LayoutState {
  final String errorMessage;

  ProductDetailsFailure({required this.errorMessage});
}

class FavProductsLoadingState extends LayoutState {}

class FavProductsSuccessState extends LayoutState {
  final List<ProductModel> favProducts;

  FavProductsSuccessState({required this.favProducts});
}

class FavProductsFailureState extends LayoutState {
  final String errorMessage;

  FavProductsFailureState({required this.errorMessage});
}

class UpdateProductsSuccessState extends LayoutState {}

class AddOrDelateFavProductSuccess extends LayoutState {}

class AddOrDelateFavProductFailure extends LayoutState {
  final String errorMessage;

  AddOrDelateFavProductFailure({required this.errorMessage});
}

class AddOrDelateFromCartSuccess extends LayoutState {}

class AddOrDelateFromCartFailure extends LayoutState {
  final String errorMessage;

  AddOrDelateFromCartFailure({required this.errorMessage});
}

class GetCartSuccess extends LayoutState {
  List<ProductModel> cartProducts;
  GetCartSuccess({required this.cartProducts});
}

class GetCartFailure extends LayoutState {
  final String errorMessage;

  GetCartFailure({required this.errorMessage});
}
