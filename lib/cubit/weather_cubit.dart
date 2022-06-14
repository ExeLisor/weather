import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whether/models/failure_mode.dart';
import 'package:whether/models/weather.dart';
import 'package:whether/repository/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepoitory weatherRepoitory;

  WeatherCubit({required this.weatherRepoitory}) : super(WeatherInitial());

  Future<void> fetchWeather() async {
    emit(WeatherLoading());
    try {
      final Weather? weather = await weatherRepoitory.getWeather();
      emit(WeatherLoaded(weather: weather!));
    } on Failure catch (err) {
      emit(WeatherError(failure: err));
    } catch (e) {
      print("Error: $e");
    }
  }
}
