import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {
  final int? id;
  final String? name;
  final String? image;

  const CategoriesModel({this.id, this.name, this.image});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };

  @override
  List<Object?> get props => [id, name, image];
}
