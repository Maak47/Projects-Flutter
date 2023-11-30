import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
// import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/get_popular_movies.dart';

import 'get_trending_movies_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late GetPopularMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });

  final tMovieList = [
    MovieEntity(
        title: 'Test Movie 1',
        id: 1,
        overview: 'overview 1 ',
        posterPath: '/image1'),
    MovieEntity(
        title: 'Test Movie 2',
        id: 1,
        overview: 'overview 2 ',
        posterPath: '/image2'),
  ];

  test('should get popular movies from the repository', () async {
    when(mockMovieRepository.getPopularMovies())
        .thenAnswer((_) async => tMovieList);

    //act
    final result = await usecase();

    //assert
    expect(result, tMovieList);
    verify(mockMovieRepository.getPopularMovies());
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
