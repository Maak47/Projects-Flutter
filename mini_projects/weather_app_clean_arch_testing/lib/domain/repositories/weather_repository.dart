import 'package:dartz/dartz.dart';
import 'package:weather_app_clean_arch_testing/core/error/failure.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
