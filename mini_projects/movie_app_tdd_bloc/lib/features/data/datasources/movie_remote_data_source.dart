import 'package:movie_app_tdd_bloc/features/data/models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrendingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> searchMovies(String query);
}
