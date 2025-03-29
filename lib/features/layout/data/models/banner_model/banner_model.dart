import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final int? id;
  final String? image;
  final dynamic category;
  final dynamic product;

  const BannerModel({this.id, this.image, this.category, this.product});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json['id'] as int?,
        image: json['image'] as String?,
        category: json['category'] as dynamic,
        product: json['product'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'category': category,
        'product': product,
      };

  @override
  List<Object?> get props => [id, image, category, product];
}
