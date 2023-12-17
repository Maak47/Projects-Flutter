import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/search/view/seach_page.dart';
import 'package:flutter_weather/settings/view/settings_page.dart';
import 'package:flutter_weather/weather/cubit/weather_cubit.dart';
import 'package:weather_repository/weather_repository.dart';
import '../../theme/theme.dart';
import '../widgets/weather_empty.dart';
import '../widgets/weather_error.dart';
import '../widgets/weather_loading.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit(context.read<WeatherRepository>()),
      child: const WeatherView(),
    );
  }
}

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push<void>(
                  SettingsPage.route(context.read<WeatherCubit>()),
                );
              },
              icon: Icon(Icons.settings)),
        ],
      ),
      body: Center(
          child: BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {
          if (state.status.isSuccess) {
            context.read<ThemeCubit>().updateTheme(state.weather);
          }
        },
        builder: (context, state) {
          switch (state.status) {
            case WeatherStatus.initial:
              return const WeatherEmpty();
            case WeatherStatus.loading:
              return const WeatherLoading();
            case WeatherStatus.success:
              return WeatherPopulated(
                  weather: state.weather,
                  units: state.temperatureUnits,
                  onRefresh: () {
                    return context.read<WeatherCubit>().refreshWeather();
                  });
            case WeatherStatus.failure:
              return const WeatherError();
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.search,
          semanticLabel: 'Search',
        ),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
