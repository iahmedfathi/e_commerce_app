import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int? id;
  final int? price;
  final int? oldPrice;
  final int? discount;
  final String? image;
  final String? name;
  final String? description;
  final List<String>? images;
  final bool? inFavorites;
  final bool? inCart;

  const ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'] as int?,
        price: (json['price'] as num?)?.toInt(),
        oldPrice: (json['old_price'] as num?)?.toInt(),
        discount: json['discount'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        images: (json['images'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        inFavorites: json['in_favorites'] as bool?,
        inCart: json['in_cart'] as bool?,
      );

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

  @override
  List<Object?> get props {
    return [
      id,
      price,
      oldPrice,
      discount,
      image,
      name,
      description,
      images,
      inFavorites,
      inCart,
    ];
  }
}
