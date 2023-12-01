import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app_tdd_bloc/core/errors/server_exceptions.dart';
import 'package:movie_app_tdd_bloc/features/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app_tdd_bloc/features/data/datasources/remote/movie_remote_data_source_impl.dart';

import 'movie_remote_data_source_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late MovieRemoteDataSource dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = MovieRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tQuery = 'Rango';

  const tUrl =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=6a96dc5481cfe7974ea2a1363ae95da6';
  const pUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=6a96dc5481cfe7974ea2a1363ae95da6';
  const sUrl =
      'https://api.themoviedb.org/3/search/movie?query=$tQuery&api_key=6a96dc5481cfe7974ea2a1363ae95da6';

  const sampleApiResponse = '''{
    "page": 1,
    "results": [
      {
        "adult": false,
        "backdrop_path": "/path.jpg",
        "id": 1,
        "title": "Sample Movie",
        "original_language": "en",
        "original_title": "Sample Movie",
        "overview": "Overview here",
        "poster_path": "/path2.jpg",
        "media_type": "movie",
        "genre_ids": [1, 2, 3],
        "popularity": 100.0,
        "release_date": "2020-01-01",
        "video": false,
        "vote_average": 7.5,
        "vote_count": 100
      }
    ],
    "total_pages": 1,
    "total_results": 1
  }''';

  test('should perform a GET request on a URL to get trending movies',
      () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(tUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.getTrendingMovies();

    // Assert
    verify(mockHttpClient.get(Uri.parse(tUrl)));
  });

  test('should perform a GET request on a URL to get popular movies', () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(pUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.getPopularMovies();

    // Assert
    verify(mockHttpClient.get(Uri.parse(pUrl)));
  });

  test('should perform a GET request on a URL to search for movies', () async {
    // Arrange
    when(mockHttpClient.get(Uri.parse(sUrl)))
        .thenAnswer((_) async => http.Response(sampleApiResponse, 200));

    // Act
    await dataSource.searchMovies(tQuery);

    // Assert
    verify(mockHttpClient.get(Uri.parse(sUrl)));
  });

  test('should throw ServerException when the response code is 404', () async {
    //arrange
    when(mockHttpClient.get(any))
        .thenAnswer((_) async => http.Response('Something Went Wrong', 404));

    //act
    final call = dataSource.getTrendingMovies;

    //assert
    expect(() => call(), throwsA(isA<ServerException>()));
  });
}
