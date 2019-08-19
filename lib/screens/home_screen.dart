import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WeatherBackground(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: isSearch ? searchBar() : Container(),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: isSearch ? null : refreshWeatherIcon(),
            actions: <Widget>[
              isSearch ? Container() : searchIcon(),
            ],
          ),
          body: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Warri, NG',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  /*Shimmer.fromColors(
                    direction: ShimmerDirection.ltr,
                    child: Text(
                      '${getWeatherIcon(600)}',
                      style: TextStyle(fontSize: 120),
                    ),
                    baseColor: Colors.yellow,
                    highlightColor: Colors.white,
                  ),*/
                  Text(
                    '${getWeatherIcon(600)}',
                    style: TextStyle(fontSize: 120),
                  ),
                  Text(
                    'Partly Cloudy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '26°',
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 60.0,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CardWidget(
                    // temperature: 800,
                    description: '( 260 )',
                    label: 'Wind',
                  ),
                  CardWidget(
                    // temperature: 17,
                    description: '58%',
                    label: 'Humidity',
                  ),
                  CardWidget(
                    // temperature: 800,
                    description: '1013 hpa',
                    label: 'Pressure',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconButton refreshWeatherIcon() {
    return IconButton(
        icon: Icon(
          Icons.near_me,
          color: Colors.white,
        ),
        onPressed: () {
          // refresh the location api
        });
  }

  IconButton searchIcon() {
    return IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          isSearch = true;
          setState(() {});
        });
  }

  TextField searchBar() {
    return TextField(
        style: TextStyle(color: Colors.white),
        autofocus: true,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(0.2),
          filled: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          hintText: 'Enter City Name',
          hintStyle: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                isSearch = false;
                setState(() {});
              }),
        ),
        onChanged: (value) {
          cityName = value.toLowerCase().trim();
        });
  }
}

class CardWidget extends StatelessWidget {
  final temperature;
  final label;
  final description;

  CardWidget(
      {@required this.label, this.temperature, @required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // width: 110.0,
        child: Card(
          margin: EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 8.0,
          ),
          elevation: 6,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  //'${getWeatherIcon(temperature)}',
                  '',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                Text(
                  '$label',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$description',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
