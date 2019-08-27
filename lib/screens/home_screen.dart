import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/components/card_widget.dart';
import 'package:weather_app/components/forecast.dart';
import 'package:weather_app/components/weather_background.dart';
import 'package:weather_app/components/weather_emoji.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  String cityName = '';
  final searchBarController = TextEditingController();
  bool showClearIcon = false;
// var currentWeather;
//  var forecastWeather;
  bool isLoading = true;
  bool isError = false;
  bool isSearchingCity = false;

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
                      getWeatherEmoji(500),
                      style: TextStyle(fontSize: 80),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      toBeginningOfSentenceCase('Moderate rain'),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '23°',
                      style: TextStyle(
                        color: Colors.white,
                        // fontWeight: FontWeight.bold,
                        fontSize: 55.0,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CardWidget(
                        icon: 'assets/images/wind.png',
                        description: '4 m/s',
                        label: 'Wind',
                      ),
                      CardWidget(
                        icon: 'assets/images/humidity.png',
                        description: '72%',
                        label: 'Humidity',
                      ),
                      CardWidget(
                        icon: 'assets/images/pressure.png',
                        description: '1011 hPa',
                        label: 'Pressure',
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '3 Hour Forecast for 5 Days',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 22.0),
                                child: ForecastWidget(
                                  date: convertTimestampToDay('2019-08-31'),
                                  temperature: 500,
                                  humidity: 72,
                                  degree: 23,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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

  Scaffold errorScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/thumb_down.gif',
              width: 120,
            ),
            Text(
              'Sorry, an error occurred, please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  isLoading = true;
                  isError = false;
                });
              },
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
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
      controller: searchBarController,
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
        prefixIcon: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              isSearch = false;
            });
          },
        ),
        suffixIcon: showClearIcon
            ? IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {
                  searchBarController.clear();
                  setState(() {
                    showClearIcon = false;
                  });
                })
            : null,
      ),
      onChanged: (value) {
        cityName = value.toLowerCase().trim();

        if (cityName.isNotEmpty) {
          setState(() {
            showClearIcon = true;
          });
        } else {
          setState(() {
            showClearIcon = false;
          });
        }
      },
    );
  }

  screens() {
    if (isLoading == true && isError == true) {
      return errorScreen();
    } else if (isLoading == true) {
      return loadingScreen();
    }
  }

  String convertTimestampToDay(String dateTime) {
    final DateTime datetime = DateTime.parse(dateTime);
    var formatter = DateFormat('E');
    var formatter2 = DateFormat('j');
    String formatted = formatter.format(datetime) +
        ' (' +
        formatter2.format(datetime).toLowerCase() +
        ')';
    return formatted;
  }
}
