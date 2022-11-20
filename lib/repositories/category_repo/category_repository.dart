import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/network/network.dart';
import 'package:king_jobs/models/category.dart';
import 'package:king_jobs/repositories/category_repo/category_local_data_source.dart';
import 'package:king_jobs/repositories/category_repo/category_remote_data_source.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<Category>>> getAllCategories();
}

class CategoryRempositoryImpl extends CategoryRepository {
  CategoryRemoteDataSourceImpl remoteDataSource;
  CategoryLocalDataSourceImpl localDataSource;
  NetworkInfo networkInfo;
  CategoryRempositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Category>>> getAllCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.getAllCategories();
        localDataSource.cacheCategories(remoteData);
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
