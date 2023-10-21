import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_clean_arch_testing/core/error/exception.dart';
import 'package:weather_app_clean_arch_testing/core/error/failure.dart';
import 'package:weather_app_clean_arch_testing/data/models/weather_model.dart';
import 'package:weather_app_clean_arch_testing/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    temperature: 285.55,
    humidity: 83,
    pressure: 1000,
    iconCode: '04d',
    cityName: 'London',
    main: 'Clouds',
    description: 'overcast clouds',
  );
  const testWeatherEntity = WeatherEntity(
    temperature: 285.55,
    humidity: 83,
    pressure: 1000,
    iconCode: '04d',
    cityName: 'London',
    main: 'Clouds',
    description: 'overcast clouds',
  );

  const testCityName = 'London';

  group('get current weather', () {
    test(
        'should return current weather when a call to data source is successful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      //assert

      expect(result, equals(const Right(testWeatherEntity)));
    });
    test(
        'should return server failure when a call to data source is unsuccessful',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      //assert

      expect(result, equals(const Left(ServerFailure('An error has occured'))));
    });

    test('should return connection failure when the device has no internet',
        () async {
      //arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException('Failed to connect to the network'));

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      //assert

      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
