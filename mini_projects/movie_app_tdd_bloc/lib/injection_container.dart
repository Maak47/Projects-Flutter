import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_tdd_bloc/features/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_tdd_bloc/features/data/datasources/remote/movie_remote_data_source_impl.dart';
import 'package:movie_app_tdd_bloc/features/data/repositories/movie_repository_impl.dart';
import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/get_popular_movies.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/get_trending_movies.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/search_movies.dart';
import 'package:movie_app_tdd_bloc/features/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app_tdd_bloc/features/presentation/bloc/trending_movies/trending_movies_bloc.dart';

import 'features/presentation/bloc/search_movies/search_movies_bloc.dart';

final getIt = GetIt.instance;

void init() {
  //bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TrendingMoviesBloc(getTrendingMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetPopularMovies(getIt()));
  getIt.registerLazySingleton(() => GetTrendingMovies(getIt()));
  getIt.registerLazySingleton(() => SearchMovies(getIt()));

  // Repositories
  getIt.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getIt()));

  // Data sources
  getIt.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: getIt()));

  // Http service
  getIt.registerLazySingleton(() => http.Client());
}
