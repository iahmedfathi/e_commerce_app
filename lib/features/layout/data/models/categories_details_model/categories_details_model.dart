class CategoriesDetailsModel {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>? images;
  bool? inFavorites;
  bool? inCart;

  CategoriesDetailsModel({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
    this.images,
    this.inFavorites,
    this.inCart,
  });

  factory CategoriesDetailsModel.fromJson(Map<String, dynamic> json) {
    return CategoriesDetailsModel(
      id: json['id'] as int?,
      price: json['price'] as num?,
      oldPrice: json['old_price'] as num?,
      discount: json['discount'] as num?,
      image: json['image'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      images: json['images'] as List<dynamic>?,
      inFavorites: json['in_favorites'] as bool?,
      inCart: json['in_cart'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'old_price': oldPrice,
        'discount': discount,
        'image': image,
        'name': name,
        'description': description,
        'images': images,
        'in_favorites': inFavorites,
        'in_cart': inCart,
      };
}
