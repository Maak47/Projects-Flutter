import 'package:dartz/dartz.dart';

import '../../../core/errors/server_failures.dart';
import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getTrendingMovies();
  Future<Either<Failure, List<MovieEntity>>> searchMovies(String query);
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
