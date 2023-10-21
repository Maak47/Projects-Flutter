import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_clean_arch_testing/data/data_sources/remote_data_source.dart';
import 'package:weather_app_clean_arch_testing/data/repositories/weather_repository_impl.dart';
import 'package:weather_app_clean_arch_testing/domain/repositories/weather_repository.dart';
import 'package:weather_app_clean_arch_testing/domain/usecases/get_current_weather.dart';
import 'package:weather_app_clean_arch_testing/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  //usecase
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  //repository

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      weatherRemoteDataSource: locator(),
    ),
  );

  //datasource
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  //external
  locator.registerLazySingleton(() => http.Client());
}
