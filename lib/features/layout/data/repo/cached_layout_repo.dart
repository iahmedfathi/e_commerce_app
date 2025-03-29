// import 'package:shop_app/constants.dart';
// import 'package:shop_app/core/errors/error_model.dart';
// import 'package:shop_app/core/errors/exceptions.dart';
// import 'package:shop_app/features/layout/data/models/banner_model/banner_model.dart';

// class CachedLayoutRepo {
//   Map<String, CachedBannerModel>? cacheMap;

//   Future<List<BannerModel>> getBannersData() async {
//     CachedBannerModel? cacheItems = cacheMap![cachedBanaresKey];
//     if (cacheItems != null && cacheItems.isValid(cachedBanaresInterval)) {
//       return cacheItems.data;
//     } else {
//       throw ServerException(
//           errModel: ErrorModel(errorMessage: 'cached error '));
//     }
//   }

//   Future<void> saveBannersToCache(
//       {required List<BannerModel> bannersModel}) async {
//     cacheMap![cachedBanaresKey] = CachedBannerModel(data: bannersModel);
//   }

//   void clearCache() {
//     cacheMap!.clear();
//   }

//   void removeFromCache(String key) {
//     cacheMap!.remove(key);
//   }
// }

// class CachedBannerModel {
//   dynamic data;
//   int cachedTime = DateTime.now().millisecondsSinceEpoch;
//   CachedBannerModel({required this.data});
// }

// extension CachedItemExtention on CachedBannerModel {
//   bool isValid(int expirationTimeInMillis) {
//     int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
//     bool isValid = currentTimeInMillis - cachedTime <= expirationTimeInMillis;
//     return isValid;
//   }
// }
