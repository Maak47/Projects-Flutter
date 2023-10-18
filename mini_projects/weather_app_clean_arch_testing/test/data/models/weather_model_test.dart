import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app_clean_arch_testing/data/models/weather_model.dart';
import 'package:weather_app_clean_arch_testing/domain/entities/weather.dart';

import '../../helpers/read_json.dart';

void main() {
  const testWeatherModel = WeatherModel(
    temperature: 285.55,
    humidity: 83,
    pressure: 1000,
    iconCode: '04d',
    cityName: 'London',
    main: 'Clouds',
    description: 'overcast clouds',
  );
  test(
    'should be sub class of weather entity ',
    () async {
      //assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  test(
    'should return a valid model from json ',
    () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(
        readJson('helpers\\dummy_data\\dummy_weather_response.json'),
      );

      //act
      final result = WeatherModel.fromJson(jsonMap);

      //expect

      expect(result, equals(testWeatherModel));
    },
  );
  test(
    'should return a json man containing proper Data ',
    () async {
      //act
      final result = testWeatherModel.toJson();

      //assert
      final expectedJsonMap = {
        'weather': [
          {
            'main': 'Clouds',
            'description': 'overcast clouds',
            'icon': '04d',
          },
        ],
        'main': {
          'temp': 285.55,
          'pressure': 1000,
          'humidity': 83,
        },
        'name': 'London',
      };
      expect(result, equals(expectedJsonMap));
    },
  );
}
