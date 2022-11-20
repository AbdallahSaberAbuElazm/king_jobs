import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:king_jobs/config/network/network.dart';
import 'package:king_jobs/controllers/category_controller.dart';
import 'package:king_jobs/controllers/country_controller.dart';
import 'package:king_jobs/controllers/job_controller.dart';
import 'package:king_jobs/controllers/user_controller.dart';
import 'package:king_jobs/repositories/category_repo/category_local_data_source.dart';
import 'package:king_jobs/repositories/category_repo/category_remote_data_source.dart';
import 'package:king_jobs/repositories/category_repo/category_repository.dart';
import 'package:king_jobs/repositories/country_repo/country_local_data_source.dart';
import 'package:king_jobs/repositories/country_repo/country_remote_data_source.dart';
import 'package:king_jobs/repositories/country_repo/country_repository.dart';
import 'package:king_jobs/repositories/job_repo/job_local_data_source.dart';
import 'package:king_jobs/repositories/job_repo/job_remote_data_source.dart';
import 'package:king_jobs/repositories/job_repo/job_repository.dart';
import 'package:king_jobs/repositories/user_repo/user_local_data_source.dart';
import 'package:king_jobs/repositories/user_repo/user_remote_data_source.dart';
import 'package:king_jobs/repositories/user_repo/user_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! countries
  //controller
  sl.registerFactory(() => CountryController(countryRepository: sl()));

  // repositories
  // sl.registerLazySingleton<CountryRemoteDataSource>(
  //     () => CountryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CountryRemoteDataSourceImpl>(
      () => CountryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CountryLocalDataSourceImpl>(
      () => CountryLocalDataSourceImpl());
  sl.registerLazySingleton<CountryRepository>(() => CountryRempositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //! category
  //controller
  sl.registerFactory(() => CategoryController(categoryRepository: sl()));
  // repositories
  sl.registerLazySingleton<CategoryRemoteDataSourceImpl>(
      () => CategoryRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<CategoryLocalDataSourceImpl>(
      () => CategoryLocalDataSourceImpl());
  sl.registerLazySingleton<CategoryRepository>(() => CategoryRempositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //! jobs
  //controller
  sl.registerFactory(() => JobController(jobRepository: sl()));
  // repositories
  sl.registerLazySingleton<JobRemoteDataSourceImpl>(
      () => JobRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<JobLocalDataSourceImpl>(
      () => JobLocalDataSourceImpl());
  sl.registerLazySingleton<JobRepository>(() => JobRempositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //! users
  //controller
  sl.registerFactory(() => UserController(userRepository: sl()));
  // repositories
  sl.registerLazySingleton<UserRemoteDataSourceImpl>(
      () => UserRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<UserLocalDataSourceImpl>(
      () => UserLocalDataSourceImpl());
  sl.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl(
      userRemoteDataSourceImpl: sl(),
      userLocalDataSourceImpl: sl(),
      networkInfo: sl()));
  //! core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  //! Exteranl
  // final sharedPreferences = await SharedPreferences.getInstance();
  // sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
  // sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => http.Client());
}
