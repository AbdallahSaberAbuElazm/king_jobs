import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int categoryId;
  // final int countryId;
  final String categoryName;
  final String imageUrl;
  final String backgroundImage;

  const Category(
      {required this.categoryName,
      required this.imageUrl,
      required this.categoryId,
      required this.backgroundImage
      // required this.countryId,
      });

  @override
  List<Object?> get props => [categoryName, imageUrl];

  static Category fromJson(Map<String, dynamic> fromJson) {
    return Category(
        categoryName: fromJson['name_ar'],
        imageUrl: fromJson['img'],
        categoryId: fromJson['id'],
        backgroundImage: fromJson['backGround_img']
        // countryId: fromJson['countryId'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      // 'countryId': countryId
    };
  }
}
