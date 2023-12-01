import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
// import 'package:movie_app_tdd_bloc/features/domain/repositories/movie_repository.dart';
import 'package:movie_app_tdd_bloc/features/domain/usecases/search_movies.dart';

import 'get_trending_movies_test.mocks.dart';

// @GenerateNiceMocks([MockSpec<MovieRepository>()])
void main() {
  late SearchMovies usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = SearchMovies(mockMovieRepository);
  });

  const tQuery = 'Rango';

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

  test('should get movies from the query from the repository', () async {
    when(mockMovieRepository.searchMovies(any))
        .thenAnswer((_) async => Right(tMovieList));

    //act
    final result = await usecase(tQuery);

    //assert
    expect(result, equals(Right(tMovieList)));
    verify(mockMovieRepository.searchMovies(tQuery));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
