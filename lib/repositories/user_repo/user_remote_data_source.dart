import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/config/util/api/upload_file.dart';
import 'package:king_jobs/models/user_service.dart';
// import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserService>> getAllUsers();
  Future<UserService> getUserProfile();
  Future<UserService> addUser({required Map<String, dynamic> userData});
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserService>> getAllUsers() async {
    var response = await client.get(Uri.parse(ApiUrl.ALL_USERS_URL));
    if (response.statusCode == 200) {
      var jsonToMap = json.decode(response.body);
      List<UserService> users = jsonToMap['users']
          .map<UserService>((userModel) => UserService.fromJson(userModel))
          .toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserService> addUser({required Map<String, dynamic> userData}) async {
    var response = await client.post(Uri.parse(ApiUrl.REGISTER_URL),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
        },
        body: jsonEncode(userData));
    if (userData['image'] != null) {
      UploadFile.uploadFile(
          file: File(userData['image']),
          storageUrl: userData['image'],
          dataType: 'file');
    }
    UploadFile.uploadFile(
        file: File(userData['cv']),
        storageUrl: userData['cv'],
        dataType: 'file');
    if (response.statusCode == 200) {
      var jsonToMap = json.decode(response.body);
      UserService users = jsonToMap['data']
          .map<UserService>((userModel) => UserService.fromJson(userModel))
          .toList();
      return users;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserService> getUserProfile() async {
    var response = await client.get(Uri.parse(
      ApiUrl.PROFILE_URL,
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonToMap = json.decode(response.body);
      UserService user = jsonToMap['data']
          .map<UserService>((userModel) => UserService.fromJson(userModel))
          .toList();
      return user;
    } else {
      throw ServerException();
    }
  }

  // Future<UserService> registerUser(Map<String, dynamic> userData) async {
  //   throw UnimplementedError();
  // }
}
