import 'package:flutter/material.dart';

import 'weather_emoji.dart';

class ForecastWidget extends StatelessWidget {
  final date;
  final temperature;
  final humidity;
  final degree;

  ForecastWidget(
      {@required this.temperature,
      @required this.humidity,
      @required this.degree,
      @required this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          '$date',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              '${getWeatherEmoji(temperature)}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '🌡️',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              '$degree°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '$humidity%',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
