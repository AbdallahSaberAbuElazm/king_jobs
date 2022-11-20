import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/models/country.dart';

abstract class CountryLocalDataSource {
  Future<Unit> cacheCountries(List<Country> countryModels);
  Future<List<Country>> getCachedData();
}

class CountryLocalDataSourceImpl implements CountryLocalDataSource {
  @override
  Future<Unit> cacheCountries(List<Country> countryModels) {
    List countryModelsToJson =
        countryModels.map((countryModel) => countryModel.toJson()).toList();
    HiveBoxes.setCachedCountries(countries: json.encode(countryModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<Country>> getCachedData() {
    final jsonString = HiveBoxes.getCachedCategories();
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<Country> decodedJsonToCategoryModels = decodeJsonData
          .map<Country>(
              (jsonCountryModels) => Country.fromJson(jsonCountryModels))
          .toList();
      return Future.value(decodedJsonToCategoryModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
