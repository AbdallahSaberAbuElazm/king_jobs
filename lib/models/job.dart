import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final int jobId;
  final String jobTitle;
  final String imageUrl;
  final int countryId;
  final int categoryId;

  const Job(
      {required this.jobTitle,
      required this.imageUrl,
      required this.jobId,
      required this.countryId,
      required this.categoryId});

  @override
  List<Object?> get props => [jobTitle, imageUrl, jobId, countryId, categoryId];

  static Job fromJson(Map<String, dynamic> fromJson) {
    return Job(
      jobTitle: fromJson['name'],
      imageUrl: fromJson['img'],
      jobId: fromJson['id'],
      countryId: int.parse(fromJson['country_id']),
      categoryId: int.parse(fromJson['cat_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'imageUrl': imageUrl,
      'jobId': jobId,
      'categoryId': categoryId
    };
  }
}
