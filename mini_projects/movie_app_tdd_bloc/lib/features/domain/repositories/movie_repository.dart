import '../entities/movie_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> getTrendingMovies();
  Future<List<MovieEntity>> searchMovies(String query);
  Future<List<MovieEntity>> getPopularMovies();
}
