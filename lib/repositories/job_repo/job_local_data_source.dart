import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/util/hive_boxes.dart';
import 'package:king_jobs/models/job.dart';

abstract class JobLocalDataSource {
  Future<Unit> cacheJobs(List<Job> jobModels);
  Future<List<Job>> getCachedData();
}

class JobLocalDataSourceImpl implements JobLocalDataSource {
  @override
  Future<Unit> cacheJobs(List<Job> jobModels) {
    List jobModelsToJson =
        jobModels.map((jobModel) => jobModel.toJson()).toList();
    HiveBoxes.setCachedJobs(jobs: json.encode(jobModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<Job>> getCachedData() {
    final jsonString = HiveBoxes.getCachedJobs();
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<Job> decodedJsonToCategoryModels = decodeJsonData
          .map<Job>((jsonJobModels) => Job.fromJson(jsonJobModels))
          .toList();
      return Future.value(decodedJsonToCategoryModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
