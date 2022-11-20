import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/network/network.dart';
import 'package:king_jobs/models/job.dart';
import 'package:king_jobs/repositories/job_repo/job_local_data_source.dart';
import 'package:king_jobs/repositories/job_repo/job_remote_data_source.dart';

abstract class JobRepository {
  Future<Either<Failure, List<Job>>> getAllJobs();
}

class JobRempositoryImpl extends JobRepository {
  JobRemoteDataSourceImpl remoteDataSource;
  JobLocalDataSourceImpl localDataSource;
  NetworkInfo networkInfo;
  JobRempositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Job>>> getAllJobs() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllJobs();
        localDataSource.cacheJobs(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getCachedData();
        return Right(localData);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
