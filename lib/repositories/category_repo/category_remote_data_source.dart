import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/models/category.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getAllCategories();
}

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final http.Client client;
  CategoryRemoteDataSourceImpl({required this.client});
  @override
  Future<List<Category>> getAllCategories() async {
    var response = await client.get(Uri.parse(ApiUrl.CATEGORIES_URL));
    if (response.statusCode == 200) {
      var jsonToMap = json.decode(response.body);
      List<Category> categories = jsonToMap['data']
          .map<Category>((countryModel) => Category.fromJson(countryModel))
          .toList();
      print('categories: $categories');
      return categories;
    } else {
      throw ServerException();
    }
  }
}
