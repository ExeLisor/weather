import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whether/cubit/weather_cubit.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({Key? key, required this.pos}) : super(key: key);

  final List pos;
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  @override
  void initState() {
    super.initState();
    context.read<WeatherCubit>().fetchWeather(widget.pos);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeatherCubit, WeatherState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
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
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        });
  }
}
