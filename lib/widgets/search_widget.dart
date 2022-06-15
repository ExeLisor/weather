import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whether/consts/cities.dart';
import 'package:whether/cubit/geolocation_cubit.dart';
import 'package:whether/cubit/internet_cubit.dart';
import 'package:whether/cubit/weather_cubit.dart';
import 'package:whether/screens/weather_page.dart';

class SearchWidget extends SearchDelegate {
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () async {
        close(context, null);
        context
            .read<WeatherCubit>()
            .fetchWeather(await context.read<GeolocationCubit>().position());
      });

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () async {
            if (query.isEmpty) {
              close(context, null);
              context.read<WeatherCubit>().fetchWeather(
                  await context.read<GeolocationCubit>().position());
            }
          },
        )
      ];

  @override
  Widget buildResults(BuildContext context) =>
      WeatherPage(pos: [cities[query]["latitude"], cities[query]["longitude"]]);

  @override
  Widget buildSuggestions(BuildContext context) {
    Iterable<String> suggestions = cities.keys.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          String key = suggestions.elementAt(index);
          return ListTile(
              title: Text(key),
              onTap: () {
                query = key;

                showResults(context);
              });
        });
  }
}










// class SearchWidget extends StatefulWidget {
//   SearchWidget({Key? key}) : super(key: key);

//   @override
//   State<SearchWidget> createState() => _SearchWidgetState();
// }

// class _SearchWidgetState extends State<SearchWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListView.builder(
//         itemCount: cities.length,
//         itemBuilder: (context, index) {
//           String key = cities.keys.elementAt(index);
//           return Column(
//             children: [
//               SizedBox(
//                 height: 40,
//                 width: MediaQuery.of(context).size.width / 2,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     print(cities[key]["latitude"]);
//                   },
//                   child: Text(key),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
