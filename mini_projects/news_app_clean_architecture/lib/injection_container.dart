import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:news_app_clean_architecture/features/daily_news/data/repository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/respository/article_repository.dart';
import 'package:news_app_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:news_app_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'features/daily_news/data/data_sources/local/app_database.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  // Dio
  sl.registerSingleton<Dio>(Dio());
  //dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  //Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
}
