import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app_tdd_bloc/core/errors/server_exceptions.dart';
import 'package:movie_app_tdd_bloc/core/errors/server_failures.dart';
import 'package:movie_app_tdd_bloc/features/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_tdd_bloc/features/data/models/movie_model.dart';
import 'package:movie_app_tdd_bloc/features/data/repositories/movie_repository_impl.dart';
import 'package:movie_app_tdd_bloc/features/domain/entities/movie_entity.dart';
import 'movie_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])
void main() {
  late MovieRepositoryImpl repositoryImpl;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();

    repositoryImpl = MovieRepositoryImpl(mockMovieRemoteDataSource);
  });

  final tMovieModelList = [
    MovieModel(
        title: 'Test Movie 1',
        id: 1,
        overview: 'overview 1 ',
        posterPath: '/image1'),
    MovieModel(
        title: 'Test Movie 2',
        id: 1,
        overview: 'overview 2 ',
        posterPath: '/image2'),
  ];

  const String tQuery = 'Rango';

  test('should get trending movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repositoryImpl.getTrendingMovies();

    verify(mockMovieRemoteDataSource.getTrendingMovies());
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });
  test('should get popular movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelList);

    final result = await repositoryImpl.getPopularMovies();

    verify(mockMovieRemoteDataSource.getPopularMovies());
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });
  test('should search movies from the remote data source', () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelList);

    final result = await repositoryImpl.searchMovies(tQuery);

    verify(mockMovieRemoteDataSource.searchMovies(tQuery));
    expect(result, isA<Right<Failure, List<MovieEntity>>>());
  });

  test(
      'should return server failure when, the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.getTrendingMovies())
        .thenThrow(ServerException());

    final result = await repositoryImpl.getTrendingMovies();
    expect(result, isA<Left<ServerFailure, List<MovieEntity>>>());
    // expect(result, equals(Left(ServerFailure)));
  });

  test(
      'should return server failure when, the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenThrow(ServerException());

    final result = await repositoryImpl.getPopularMovies();
    expect(result, isA<Left<ServerFailure, List<MovieEntity>>>());
  });

  test(
      'should return server failure when, the call to remote data source is unsuccessful',
      () async {
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenThrow(ServerException());

    final result = await repositoryImpl.searchMovies(tQuery);
    expect(result, isA<Left<ServerFailure, List<MovieEntity>>>());
  });
}
