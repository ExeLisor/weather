import 'dart:convert';

import 'package:whether/models/weather.dart';
import 'package:whether/services/weather_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherRepoitory {
  WeatherRepoitory({required this.weatherService});

  final WeatherService weatherService;

  Future<Weather?> getWeather(String lat, String lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await weatherService.getWeather(lat, lon);
    if (response != null) {
      final data = await response.transform(utf8.decoder).join();
      prefs.setString('weather', data);
      prefs.setString("time", DateTime.now().toString());
      print(prefs.getString("time"));
      return Weather.fromMap(jsonDecode(data));
    }
    return null;
  }

  Future<Weather?> getWeatherFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("weather");
    return Weather.fromMap(jsonDecode(data ?? ''));
  }
}




// Future fetchWeather(String lat, String lon) async {
//   try {
//     final result = await InternetAddress.lookup('google.com');
//     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//       HttpClient client = HttpClient();
//       final uri = Uri.parse(
//           "https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&cnt=40&appid=8e2c690febca531a10e946a7149ed8fb&units=metric&lang=ru");
//       HttpClientRequest request = await client.getUrl(uri);
//       HttpClientResponse response = await request.close();
//       String reply = await response.transform(utf8.decoder).join();
//       if (response.statusCode == 200) {
//         print(jsonDecode(reply));
//         return Weather.fromMap(jsonDecode(reply));
//       } else {
//         throw Exception(response.statusCode);
//       }
//     }
//   } on SocketException catch (_) {}
// }


