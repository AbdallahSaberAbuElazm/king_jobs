import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/models/user_service.dart';

abstract class UserLocalDataSource {
  Future<Unit> cacheUsers(List<UserService> userService);
  Future<List<UserService>> getCachedData();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<Unit> cacheUsers(List<UserService> userService) {
    HiveBoxes.setCachedUser(
        user: json.encode(userService.map((user) => user.toMap()).toList()));
    return Future.value(unit);
  }

  @override
  Future<List<UserService>> getCachedData() {
    final jsonString = HiveBoxes.getCachedJobs();
    if (jsonString != null) {
      var decodeJsonData = json.decode(jsonString);
      List<UserService> users =
          decodeJsonData.map((user) => UserService.fromJson(user)).toList();
      return Future.value(users);
    } else {
      throw EmptyCacheException();
    }
  }
}
