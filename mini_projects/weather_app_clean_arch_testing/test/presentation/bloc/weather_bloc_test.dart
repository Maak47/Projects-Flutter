import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_clean_arch_testing/core/error/failure.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';
import 'package:weather_app_clean_arch_testing/presentation/bloc/weather_bloc.dart';
import 'package:weather_app_clean_arch_testing/presentation/bloc/weather_event.dart';
import 'package:weather_app_clean_arch_testing/presentation/bloc/weather_state.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase);
  });
  const testWeather = WeatherEntity(
    temperature: 285.55,
    humidity: 83,
    pressure: 1000,
    iconCode: '04d',
    cityName: 'London',
    main: 'Clouds',
    description: 'overcast clouds',
  );
  const testCityName = 'London';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });
  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => <WeatherState>[
      WeatherLoading(),
      const WeatherLoaded(testWeather),
    ],
  );
  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeatherUseCase.execute(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailure('Server Failure'),
          ]);
}
