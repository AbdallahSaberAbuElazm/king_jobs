import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/models/category.dart';

abstract class CategoryLocalDataSource {
  Future<Unit> cacheCategories(List<Category> categoryModels);
  Future<List<Category>> getCachedData();
}

class CategoryLocalDataSourceImpl extends CategoryLocalDataSource {
  @override
  Future<Unit> cacheCategories(List<Category> categoryModels) {
    List categoryModelsToJson =
        categoryModels.map((categoryModel) => categoryModel.toJson()).toList();
    HiveBoxes.setCachedCategories(
        categories: json.encode(categoryModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<Category>> getCachedData() {
    final jsonString = HiveBoxes.getCachedCategories();
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<Category> decodedJsonToCategoryModels = decodeJsonData
          .map<Category>(
              (jsonCategoryModels) => Category.fromJson(jsonCategoryModels))
          .toList();
      return Future.value(decodedJsonToCategoryModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
