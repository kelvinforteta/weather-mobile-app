import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/components/forecast.dart';
import 'package:weather_app/components/weather_emoji.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  String cityName;

  @override
  Widget build(BuildContext context) {
    return buildStackWidget();
  }

  Stack buildStackWidget() {
    return Stack(
      children: <Widget>[
        WeatherBackground(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: isSearch ? searchBar() : Text('Today'),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: isSearch ? null : refreshWeatherIcon(),
            actions: <Widget>[
              isSearch ? Container() : searchIcon(),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 5,
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
                    Text(
                      '${getWeatherEmoji(200)}',
                      style: TextStyle(fontSize: 100),
                    ),
                    SizedBox(
                      height: 5,
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
                        fontSize: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '5 Days Forecast',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ForecastWidget(
                            day: 'Wed',
                            temperature: 300,
                            degree: 25,
                          ),
                          ForecastWidget(
                            day: 'Thu',
                            temperature: 500,
                            degree: 27,
                          ),
                          ForecastWidget(
                            day: 'Fri',
                            temperature: 100,
                            degree: -5,
                          ),
                          ForecastWidget(
                            day: 'Sat',
                            temperature: 200,
                            degree: 15,
                          ),
                          ForecastWidget(
                            day: 'Sun',
                            temperature: 800,
                            degree: 35,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Scaffold loadingScreen() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Shimmer.fromColors(
            baseColor: Colors.purple[900],
            highlightColor: Colors.pink[700],
            child: Text(
              'Loading...',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
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
