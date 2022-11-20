import 'package:equatable/equatable.dart';

class UserService extends Equatable {
  int? userId;
  final String firstName;
  final String email;
  final String gender;
  final String phoneNumber;
  final String phoneExt;
  final String yearsExp;
  final String image;
  final String cv;
  final int jobId;
  final String job;
  final String description;
  final String coupon;

  UserService(
      {this.userId,
      required this.firstName,
      required this.email,
      required this.gender,
      required this.phoneNumber,
      required this.yearsExp,
      required this.cv,
      required this.image,
      required this.jobId,
      required this.job,
      required this.description,
      required this.coupon,
      required this.phoneExt});

  @override
  List<Object?> get props => [
        userId,
        firstName,
        email,
        gender,
        phoneNumber,
        phoneExt,
        yearsExp,
        cv,
        image,
        jobId,
        job,
        description,
        coupon
      ];

  static UserService fromJson(Map<String, dynamic> fromJson) {
    return UserService(
        userId: fromJson['id'],
        firstName: fromJson['first_name'],
        email: fromJson['email'],
        gender: fromJson['gender'],
        phoneNumber: fromJson['phone'],
        phoneExt: fromJson['phone_ext'],
        yearsExp: fromJson['yearsExp'],
        cv: fromJson['cv'],
        image: fromJson['image'],
        jobId: int.parse(fromJson['jobId']),
        job: fromJson['last_name'],
        description: fromJson['description'],
        coupon: fromJson['coupon']);
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'email': email,
      'gender': gender,
      'phone': phoneNumber,
      'phone_ext': phoneExt,
      'yearsExp': yearsExp,
      'cv': cv,
      'image': image,
      'jobId': jobId,
      'description': description,
      'coupon': coupon
    };
  }
}
