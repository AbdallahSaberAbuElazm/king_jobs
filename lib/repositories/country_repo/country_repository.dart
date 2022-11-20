import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/network/network.dart';
import 'package:king_jobs/models/country.dart';
import 'package:king_jobs/repositories/country_repo/country_local_data_source.dart';
import 'package:king_jobs/repositories/country_repo/country_remote_data_source.dart';

abstract class CountryRepository {
  Future<Either<Failure, List<Country>>> getAllCountries();
}

class CountryRempositoryImpl extends CountryRepository {
  CountryRemoteDataSourceImpl remoteDataSource;
  CountryLocalDataSourceImpl localDataSource;
  NetworkInfo networkInfo;
  CountryRempositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Country>>> getAllCountries() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllCountries();
        localDataSource.cacheCountries(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await localDataSource.getCachedData();
        print('local data : $localData');
        return Right(localData);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
