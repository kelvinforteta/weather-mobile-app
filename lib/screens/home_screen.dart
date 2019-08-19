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
          body: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: 15,
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
                    '${getWeatherIcon(200)}',
                    style: TextStyle(fontSize: 120),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Partly Cloudy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 5,
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CardWidget(
                      icon: 'assets/images/wind.png',
                      description: '1.5 mph',
                      label: 'Wind',
                    ),
                    CardWidget(
                      icon: 'assets/images/humidity.png',
                      description: '58%',
                      label: 'Humidity',
                    ),
                    CardWidget(
                      icon: 'assets/images/pressure.png',
                      description: '1013 hpa',
                      label: 'Pressure',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '16 Days Forecast',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                      MoreWeatherBroadcast(
                        day: 'Wed',
                        temperature: 800,
                        degree: 30,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Thu',
                        temperature: 300,
                        degree: 21,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Fri',
                        temperature: 600,
                        degree: 15,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sat',
                        temperature: 700,
                        degree: 14,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                      MoreWeatherBroadcast(
                        day: 'Sun',
                        temperature: 100,
                        degree: -5,
                      ),
                    ],
                  ),
                ),
              )
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

class MoreWeatherBroadcast extends StatelessWidget {
  final day;
  final temperature;
  final degree;

  MoreWeatherBroadcast(
      {@required this.temperature, @required this.day, @required this.degree});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: <Widget>[
          Expanded(
              child: Text(
            day,
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
          Expanded(
              child: Text(
            '${getWeatherIcon(temperature)}',
            style: TextStyle(fontSize: 20),
          )),
          Expanded(
              child: Text(
            '$degree°',
            style: TextStyle(color: Colors.white, fontSize: 15),
          )),
        ],
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final icon;
  final label;
  final description;

  CardWidget({@required this.label, this.icon, @required this.description});

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
                Image.asset(
                  icon,
                  height: 40,
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
