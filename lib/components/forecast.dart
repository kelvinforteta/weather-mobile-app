import 'package:flutter/material.dart';

import 'weather_emoji.dart';

class ForecastWidget extends StatelessWidget {
  final day;
  final temperature;
  final degree;

  ForecastWidget(
      {@required this.temperature, @required this.day, @required this.degree});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            day,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '${getWeatherEmoji(temperature)}',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '$degree°',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
