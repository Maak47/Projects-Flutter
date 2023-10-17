import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_arch_testing/core/error/failure.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';
import 'package:weather_app_clean_arch_testing/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;
  GetCurrentWeatherUseCase(this.weatherRepository);
  Future<Either<Failure, WeatherEntity>> execute(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
