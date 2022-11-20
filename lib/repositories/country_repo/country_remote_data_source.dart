import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/models/country.dart';

abstract class CountryRemoteDataSource {
  Future<List<Country>> getAllCountries();
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final http.Client client;
  CountryRemoteDataSourceImpl({required this.client});
  @override
  Future<List<Country>> getAllCountries() async {
    var response = await client.get(Uri.parse(ApiUrl.COUNTRIES_URL));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonToMap = json.decode(response.body);
      List<Country> countries = jsonToMap['data']
          .map<Country>((countryModel) => Country.fromJson(countryModel))
          .toList();
      return countries;
    } else {
      throw ServerException();
    }
  }
}
