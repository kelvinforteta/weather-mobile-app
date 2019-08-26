import 'package:flutter/material.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() => runApp(WeatherApp());

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      color: Colors.white,
      home: HomeScreen(),
    );
  }
}
