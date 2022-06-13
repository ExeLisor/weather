import 'dart:convert';
import 'dart:io';
import 'package:whether/models/weather.dart';

Future fetchWeather(String lat, String lon) async {
  HttpClient client = HttpClient();
  final uri = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=8e2c690febca531a10e946a7149ed8fb");
  HttpClientRequest request = await client.getUrl(uri);
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  if (response.statusCode == 200) {
    print(reply);
    return Weather.fromJson(jsonDecode(reply));
  } else {
    throw Exception(response.statusCode);
  }
}
