import 'package:dartz/dartz.dart';
import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';

import '../../../core/errors/server_failures.dart';

class SearchMovies {
  final MovieRepository repository;
  SearchMovies(this.repository);

  Future<Either<Failure, List<MovieEntity>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}
