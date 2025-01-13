import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_tracker_v1/bloc/weather_bloc_bloc.dart';
import 'package:weather_tracker_v1/screens/home/home_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  //flutter_dotenv is a Flutter package that allows you to load environment variables from a .env file in your Flutter application
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //Future builder is a widget that interact and rebuild based on the future function
      //In nature future builder is a stateful widget
      home: FutureBuilder(
          future: _determinePosition(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //**
              // Bloc Provider take the instantance of a bloc that's in the create function and pass it to it's child using philosphy of dependency injection
              // Now home screen or children of the homescreen can called state of the bloc using the blocbuilder v 
              // */

              //The create return the new instance of the WeatherBlocBloc and add the FetchWeather event to the bloc
              //Homescreen and all it's descendants will have access to the WeatherBlocBloc instance
              return BlocProvider<WeatherBlocBloc>(
                create: (context) => WeatherBlocBloc()..add(FetchWeather(snapshot.data as Position)),
                child: HomeScreen(),
              );
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
  }
}

/**
 * The following function is apart of the geolocation plugin which it grabbing the current position include checking if the location
 * service are enable or not. It also request permission to access the user location if it not enable
 */

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
