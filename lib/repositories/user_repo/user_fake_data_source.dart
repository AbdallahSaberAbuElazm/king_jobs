// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:king_jobs/models/user_service.dart';
// import 'package:king_jobs/repositories/user_repo/user_repository.dart';

// class UserFakeData implements UserRepository {
//   @override
//   Future<List<UserService>> getAllUsers() async {
//     final String response =
//         await rootBundle.loadString('assets/datasamples/user_data.json');
//     final data = await json.decode(response);
//     List<UserService> users = data["items"]
//         .map<UserService>((userModel) => UserService.fromJson(userModel))
//         .toList();
//     return users;
//   }
  
//   @override
//   Future<UserService> addUser() {
//     // TODO: implement addUser
//     throw UnimplementedError();
//   }
// }
