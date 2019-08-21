import 'package:flutter/material.dart';

class WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink[700],
            Colors.purple[900],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        /*image: DecorationImage(
          image: NetworkImage(
              'https://cdn.pixabay.com/photo/2016/11/29/11/12/adult-1869119_960_720.jpg'),
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}
