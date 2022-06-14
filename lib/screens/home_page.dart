import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whether/cubit/weather_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherError) {
            return Text(state.failure.message);
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            return weather.list.isEmpty
                ? const Text('is empty')
                : Text(weather.city.name);
          }
          return const Placeholder();
        },
      ),
    ));
  }
}
