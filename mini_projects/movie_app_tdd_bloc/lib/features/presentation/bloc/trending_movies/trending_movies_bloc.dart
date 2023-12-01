import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/get_trending_movies.dart';
import 'package:movie_app_tdd_bloc/features/presentation/bloc/trending_movies/trending_movies_event.dart';
import 'package:movie_app_tdd_bloc/features/presentation/bloc/trending_movies/trending_movies_state.dart';

class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final GetTrendingMovies getTrendingMovies;

  TrendingMoviesBloc({required this.getTrendingMovies})
      : super(TrendingMoviesInitial()) {
    on<FetchTrendingMovies>((event, emit) async {
      emit(TrendingMoviesLoading());
      final failureOrMovies = await getTrendingMovies();
      failureOrMovies.fold(
          (failure) => emit(TrendingMoviesError(failure.toString())),
          (movies) => emit(TrendingMoviesLoaded(movies)));
    });
  }
}
