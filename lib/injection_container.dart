import 'package:henry_flutter_news/features/news/data/datasources/news_hive_helper.dart';
import 'package:henry_flutter_news/features/news/data/datasources/news_local_data_source.dart';
import 'package:henry_flutter_news/features/news/data/datasources/news_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:henry_flutter_news/features/news/data/repositories/news_repository_impl.dart';
import 'package:henry_flutter_news/features/news/domain/repositories/news_repository.dart';
import 'package:henry_flutter_news/features/news/domain/usecases/get_news.dart';
import 'package:henry_flutter_news/features/news/presentation/bloc/news_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // NEWS

  // DATA

  //Datasources
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(hive: sl()));

  // Repositories
  sl.registerLazySingleton<NewsRepository>(
      () => NewsRepositoryImpl(localDataSource: sl(), remoteDataSource: sl()));

  // Domain

  // Usecases
  sl.registerLazySingleton(() => GetNews(repository: sl()));

  // presentation

  // bloc
  sl.registerFactory(() => NewsBloc(getNewsUsecase: sl()));

  // Misc
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => NewsHiveHelper());
}
