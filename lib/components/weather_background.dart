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
            Color(0xFF28BFF0),
            Color(0xFF6553ED),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
        ),
        /*image: DecorationImage(
          image: NetworkImage(
              'https://cdn.pixabay.com/photo/2019/08/21/09/29/norway-4420668_960_720.jpg'),
          fit: BoxFit.cover,
        ),*/
      ),
    );
  }
}
