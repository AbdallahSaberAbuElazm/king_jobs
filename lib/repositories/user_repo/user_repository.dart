import 'package:dartz/dartz.dart';
import 'package:king_jobs/config/error/exception.dart';
import 'package:king_jobs/config/error/failure.dart';
import 'package:king_jobs/config/network/network.dart';
import 'package:king_jobs/models/user_service.dart';
import 'package:king_jobs/repositories/user_repo/user_local_data_source.dart';
import 'package:king_jobs/repositories/user_repo/user_remote_data_source.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserService>>> getAllUsers();
  Future<Either<Failure, UserService>> addUser(
      {required Map<String, dynamic> userData});
}

class UserRepositoryImpl extends UserRepository {
  NetworkInfo networkInfo;
  UserRemoteDataSourceImpl userRemoteDataSourceImpl;
  UserLocalDataSourceImpl userLocalDataSourceImpl;

  UserRepositoryImpl(
      {required this.userLocalDataSourceImpl,
      required this.userRemoteDataSourceImpl,
      required this.networkInfo});
  @override
  Future<Either<Failure, UserService>> addUser(
      {required Map<String, dynamic> userData}) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData =
            await userRemoteDataSourceImpl.addUser(userData: userData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(EmptyCacheFailure());
    // else {
    //   try {
    //     // final localData = await userLocalDataSourceImpl.getCachedData();
    //     // return Right(localData);
    //   } on EmptyCacheException {
    //     return Left(EmptyCacheFailure());
    //   }
    // }
  }

  @override
  Future<Either<Failure, List<UserService>>> getAllUsers() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await userRemoteDataSourceImpl.getAllUsers();
        userLocalDataSourceImpl.cacheUsers(remoteData);
        return Right(remoteData);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localData = await userLocalDataSourceImpl.getCachedData();
        return Right(localData);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
