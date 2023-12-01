import 'package:dartz/dartz.dart';
import 'package:movie_app_tdd_bloc/core/errors/server_exceptions.dart';
import 'package:movie_app_tdd_bloc/features/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_tdd_bloc/features/data/models/movie_model.dart';
import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';

import '../../../core/errors/server_failures.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<ServerFailure, List<MovieEntity>>> getPopularMovies() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getPopularMovies();
      final List<MovieEntity> movies =
          movieModels.map((e) => e.toEntity()).toList();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<MovieEntity>>> getTrendingMovies() async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.getTrendingMovies();
      final List<MovieEntity> movies =
          movieModels.map((e) => e.toEntity()).toList();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure, List<MovieEntity>>> searchMovies(
      String query) async {
    try {
      final List<MovieModel> movieModels =
          await remoteDataSource.searchMovies(query);
      final List<MovieEntity> movies =
          movieModels.map((e) => e.toEntity()).toList();

      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
