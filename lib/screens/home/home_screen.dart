import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_tracker_v1/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          //The BlocBuilder is a widget that listen to the state of the bloc and rebuild the widget based on the state of the bloc
          child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
              if (state is WeatherBlocSuccess) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Align(
                        alignment: AlignmentDirectional(3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(-3, -0.3),
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.deepPurple),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0, -1.2),
                        child: Container(
                          height: 300,
                          width: 600,
                          decoration: BoxDecoration(color: Color(0xFFFFAB40)),
                        ),
                      ),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              //Render the area name from the weather data
                              '${state.weather.areaName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Good Morning',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            displayWeatherCondition(state.weather.weatherConditionCode!),
                            Center(
                              //Render the temperature from the weather data
                              child: Text(
                                '${state.weather.temperature!.fahrenheit!.round()} °F',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Center(
                              child: Text(
                                "${state.weather.weatherDescription}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Center(
                              //Render the current time and day
                              child: Text(
                                "${getCurrentTimeAndDay()}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/sunrise.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          DateFormat().add_jm().format(state.weather.sunrise!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/sunset.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Sunset',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          //Render the sunset time from the weather data after formnsatting it
                                          DateFormat().add_jm().format(state.weather.sunset!),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/temp_max.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Max',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        //Render the max temperature from the weather data
                                        Text(
                                          '${state.weather.tempMax!.fahrenheit!.round()} °F',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/temp_min.png',
                                      scale: 8,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Temp Min',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        //Render the min temperature from the weather data
                                        Text(
                                        '${state.weather.tempMin!.fahrenheit!.round()} °F',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: Text("Please try again"),
                  ),
                );
              }
            },
          ),
        ));
  }
}

String getCurrentTimeAndDay() {
  var now = DateTime.now();
  var formatter = DateFormat('EEEE d -').add_jm();
  return formatter.format(now);
}

Widget displayWeatherCondition(int weatherCode){
  switch(weatherCode){
    case >= 200 && < 300:
      return Image.asset('assets/thunder_cloud.png');
    case >= 300 && < 400:
      return Image.asset('assets/rain_cloud.png');
    case >= 500 && < 600:
      return Image.asset('assets/heavy_rain.png');   
    case >= 600 && < 700:
      return Image.asset('assets/snow.png');   
    case >= 700 && < 800:
      return Image.asset('assets/windy.png');   
    case == 800:
      return Image.asset('assets/sunny.png');
    case > 800 && <= 804:
      return Image.asset('assets/cloud.png');
    default:
       return Image.asset('assets/cloud.png');     
  }
}

