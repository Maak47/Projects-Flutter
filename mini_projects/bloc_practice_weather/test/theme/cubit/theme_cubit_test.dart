import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../lib/theme/cubit/theme_cubit.dart';
import '../../../lib/weather/weather.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/hydrated_bloc.dart';

class MockWeather extends Mock implements Weather {
  MockWeather(this._condition);
  final WeatherCondition _condition;

  @override
  WeatherCondition get condition => _condition;
}

void main() {
  initHydratedStorage();

  group('toJson/FromJson', () {
    test('work properly', () {
      final themeCubit = ThemeCubit();
      expect(themeCubit.fromJson(themeCubit.toJson(themeCubit.state)),
          themeCubit.state);
    });
  });

  group('updateTheme', () {
    final clearWeather = MockWeather(WeatherCondition.clear);
    final snowyWeather = MockWeather(WeatherCondition.snowy);
    final rainyWeather = MockWeather(WeatherCondition.rainy);
    final cloudyWeather = MockWeather(WeatherCondition.cloudy);
    final unknownWeather = MockWeather(WeatherCondition.unknown);

    blocTest<ThemeCubit, Color>(
      'emit correct color for WeatherCondition.clear',
      build: ThemeCubit.new,
      act: (cubit) => cubit.updateTheme(clearWeather),
      expect: () => <Color>[Colors.yellow],
    );
    blocTest<ThemeCubit, Color>(
      'emit correct color for WeatherCondition.snowy',
      build: ThemeCubit.new,
      act: (cubit) => cubit.updateTheme(snowyWeather),
      expect: () => <Color>[Colors.lightBlueAccent],
    );
    blocTest<ThemeCubit, Color>(
      'emit correct color for WeatherCondition.rainy',
      build: ThemeCubit.new,
      act: (cubit) => cubit.updateTheme(rainyWeather),
      expect: () => <Color>[Colors.indigoAccent],
    );
    blocTest<ThemeCubit, Color>(
      'emit correct color for WeatherCondition.cloudy',
      build: ThemeCubit.new,
      act: (cubit) => cubit.updateTheme(cloudyWeather),
      expect: () => <Color>[Colors.blueGrey],
    );
    blocTest<ThemeCubit, Color>(
      'emit correct color for WeatherCondition.unknown',
      build: ThemeCubit.new,
      act: (cubit) => cubit.updateTheme(unknownWeather),
      expect: () => <Color>[Colors.yellow],
    );
  });
}
