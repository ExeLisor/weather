import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whether/cubit/geolocation_cubit.dart';
import 'package:whether/cubit/internet_cubit.dart';
import 'package:whether/cubit/weather_cubit.dart';
import 'package:whether/widgets/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late GeolocationState geolocationState;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchWidget());
            })
      ]),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, internetState) async {
          if (internetState is InternetConnected &&
              internetState.internetConnected) {
            print("connected!");
            context.read<WeatherCubit>().fetchWeather(
                await context.read<GeolocationCubit>().position());
          } else if (internetState is InternetDisconnected) {
            context.read<WeatherCubit>().fetchWeatherFromCache();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            print('no connection!');
            // print(DateTime.now()
            //     .difference(DateTime.parse(prefs.getString("time")!))
            //     .inSeconds);
          }
        },
        child: Center(
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
        ),
      ),
    );
  }
}
