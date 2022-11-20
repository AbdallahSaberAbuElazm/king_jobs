import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/api/api_url.dart';
import 'package:king_jobs/models/job.dart';

abstract class JobRemoteDataSource {
  Future<List<Job>> getAllJobs();
}

class JobRemoteDataSourceImpl extends JobRemoteDataSource {
  final http.Client client;
  JobRemoteDataSourceImpl({required this.client});
  @override
  Future<List<Job>> getAllJobs() async {
    var response = await client.get(Uri.parse(ApiUrl.JOBS_URL));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonToMap = json.decode(response.body);

      // if (jsonToMap['jobs'] == categoryId.toString()) {
      List<Job> jobs = jsonToMap['jobs']
          .map<Job>((jobModel) => Job.fromJson(jobModel))
          .toList();
      return jobs;
    } else {
      throw ServerException();
    }
  }
}
