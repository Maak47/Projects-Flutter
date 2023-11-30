import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  GetTrendingMovies(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getTrendingMovies();
  }
}
