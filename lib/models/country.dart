import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String countryNameAr;
  final String countryNameEn;
  final String imageUrl;
  final int countryId;

  const Country(
      {required this.countryNameAr,
      required this.countryNameEn,
      required this.imageUrl,
      required this.countryId});
  @override
  List<Object?> get props => [
        countryNameAr, countryNameEn, countryId,
        //  imageUrl
      ];

  static Country fromJson(Map<String, dynamic> fromJson) {
    return Country(
        countryNameAr: fromJson['name_ar'],
        countryNameEn: fromJson['name_en'],
        imageUrl: fromJson['country_img'],
        countryId: fromJson['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'countryNameAr': countryNameAr,
      'countryNameEn': countryNameEn,
      'country_img': imageUrl,
      'countryId': countryId
    };
  }
}
