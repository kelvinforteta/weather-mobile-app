import 'package:flutter/material.dart';

import 'weather_emoji.dart';

class ForecastWidget extends StatelessWidget {
  final date;
  final temperatureDay;
  final temperatureNight;
  final degreeDay;
  final degreeNight;

  ForecastWidget(
      {@required this.temperatureDay,
      @required this.temperatureNight,
      @required this.degreeDay,
      @required this.degreeNight,
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
              '${getWeatherEmoji(temperatureDay)}',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '${getWeatherEmoji(temperatureNight)}',
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
              '$degreeDay°',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '$degreeNight°',
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
