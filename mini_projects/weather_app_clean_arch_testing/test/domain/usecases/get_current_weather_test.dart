import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';
import 'package:weather_app_clean_arch_testing/domain/usecases/get_current_weather.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  MockWeatherRepository mockWeatherRepository;
  mockWeatherRepository = MockWeatherRepository();
  getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);

  setUp(() {
    mockWeatherRepository;
    getCurrentWeatherUseCase;
  });
  const testWeatherDetail = WeatherEntity(
    cityName: 'Thikri',
    main: 'sun',
    description: 'suuny day',
    iconCode: '0x2',
    temperature: 421,
    pressure: 51,
    humidity: 23,
  );
  const testCityName = 'Thikri';
  test('should get current weather detail from the repository', () async {
    //arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherDetail));

    // act
    final result = await getCurrentWeatherUseCase.execute(testCityName);

    // assert
    expect(result, const Right(testWeatherDetail));
  });
}
