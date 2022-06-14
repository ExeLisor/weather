import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whether/cubit/weather_cubit.dart';
import 'package:whether/services/weather_service.dart';
import 'repository/weather_repository.dart';
import 'screens/home_page.dart';

void main() {
  runApp(MyApp(
    weatherService: WeatherService(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.weatherService}) : super(key: key);

  final WeatherService weatherService;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeatherCubit>(
          create: (context) => WeatherCubit(
            weatherRepoitory: WeatherRepoitory(
              weatherService: WeatherService(),
            ),
          )..fetchWeather(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
//   // String latitude = '';
//   // String longitude = '';

//   // late Weather weather;

//   // currentWeatherLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     return Future.error('Location services are disabled');
//   //   }
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }
//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }
//   //   Position position = await _geolocatorPlatform.getCurrentPosition();
//   //   latitude = position.latitude.toString();
//   //   longitude = position.longitude.toString();
//   //   fetchWeather(latitude, longitude).then(
//   //     (value) {
//   //       {
//   //         setState(() {
//   //           weather = value;
//   //         });
//   //       }
//   //     },
//   //   );
//   // }

//   @override
//   void initState() {
//     super.initState();
//     // currentWeatherLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => WeatherPage(),
//                     ),
//                   );
//                 },
//                 child: Container())
//           ],
//         ),
//       ),
//     );
//   }
// }
