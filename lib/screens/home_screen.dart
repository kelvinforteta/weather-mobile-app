import 'dart:async';
import 'dart:convert';

import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:weather_app/components/card_widget.dart';
import 'package:weather_app/components/forecast.dart';
import 'package:weather_app/components/weather_background.dart';
import 'package:weather_app/components/weather_emoji.dart';

const apiKey = '533604a1f76fd0c5b9def2ffab56d1cd';
const weatherApiUrl = 'https://api.openweathermap.org/data/2.5/';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearch = false;
  String cityName = '';
  final searchBarController = TextEditingController();
  bool showClearIcon = false;
  var currentWeather;
  var forecastWeather;
  bool isLoading = true;
  bool isError = false;
  bool isSearchingCity = false;
  Timer timer;
  bool isNavigationIconTapped = false;

  @override
  void initState() {
    super.initState();
    getWeatherUpdate();

    // fetch the data every 1 hour
    timer = Timer.periodic(
        Duration(hours: 1), (Timer t) => getWeatherUpdateEveryHour());
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? screens() : buildStackWidget();
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
            leading: isSearch ? null : loaderNavigationIcon(),
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
                      '${currentWeather['name']}, ${currentWeather['sys']['country']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${getWeatherEmoji(currentWeather['weather'][0]['id'])}',
                      style: TextStyle(fontSize: 80),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      toBeginningOfSentenceCase(
                          currentWeather['weather'][0]['description']),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${currentWeather['main']['temp'].round()}°',
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
                        description: '${currentWeather['wind']['speed']} m/s',
                        label: 'Wind',
                      ),
                      CardWidget(
                        icon: 'assets/images/humidity.png',
                        description:
                            '${currentWeather['main']['humidity'].round()}%',
                        label: 'Humidity',
                      ),
                      CardWidget(
                        icon: 'assets/images/pressure.png',
                        description:
                            '${currentWeather['main']['pressure'].toInt()} hPa',
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
                            itemCount: forecastWeather['cnt'],
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(right: 22.0),
                                child: ForecastWidget(
                                  date: convertTimestampToDay(
                                      forecastWeather['list'][index]['dt_txt']),
                                  temperature: forecastWeather['list'][index]
                                      ['weather'][0]['id'],
                                  humidity: forecastWeather['list'][index]
                                      ['main']['humidity'],
                                  degree: forecastWeather['list'][index]['main']
                                          ['temp']
                                      .round(),
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
                getWeatherUpdate();
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
          setState(() {
            isNavigationIconTapped = true;
          });
          // refresh the location api
          getWeatherUpdate();
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
        prefixIcon: loaderBackButton(),
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
      onSubmitted: (value) {
        String cityName = value.toLowerCase().trim();
        if (cityName.isNotEmpty) {
          setState(() {
            isSearchingCity = true;
          });
          getWeatherUpdateByCity(cityName);
        }
      },
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

  void getWeatherUpdate() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    var client = new Client();
    List<String> urls = [
      'weather?lat=${position.latitude}&lon=${position.longitude}',
      'forecast?lat=${position.latitude}&lon=${position.longitude}',
    ]; //different ids

    try {
      List<Response> list = await Future.wait(urls.map((urlId) =>
          client.get('$weatherApiUrl/$urlId&appid=$apiKey&units=metric')));

      print(list[0].statusCode);

      if (list[0].statusCode == 200 && list[1].statusCode == 200) {
        setState(() {
          currentWeather = jsonDecode(list[0].body);
          forecastWeather = jsonDecode(list[1].body);
          isLoading = false;
          isNavigationIconTapped = false;
        });
      } else {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      if (isNavigationIconTapped) {
        Toast.show("Sorry, no internet connect found.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      }
      setState(() {
        isError = true;
        isNavigationIconTapped = false;
      });
    } finally {
      client.close();
    }
  }

  void getWeatherUpdateByCity($cityName) async {
    var client = new Client();
    List<String> urls = [
      'weather?q=$cityName',
      'forecast?q=$cityName',
    ]; //different ids

    try {
      List<Response> list = await Future.wait(urls.map((urlId) =>
          client.get('$weatherApiUrl/$urlId&appid=$apiKey&units=metric')));

      if (list[0].statusCode == 200 && list[1].statusCode == 200) {
        setState(() {
          currentWeather = jsonDecode(list[0].body);
          forecastWeather = jsonDecode(list[1].body);
          isLoading = false;
          isSearch = false;
          isSearchingCity = false;
        });
      } else if (list[0].statusCode == 404 && list[1].statusCode == 404) {
        setState(() {
          isSearchingCity = false;
          searchBarController.clear();
          Toast.show("City not found.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          // isError = true;
        });
      } else {
        setState(() {
          isSearchingCity = false;
          Toast.show("Sorry, an error occurred, try again.", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
          // isError = true;
        });
      }
    } catch (e) {
      setState(() {
        isSearchingCity = false;
        Toast.show("Sorry, no internet connect found.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
        // isError = true;
      });
    } finally {
      client.close();
    }
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

  loaderBackButton() {
    if (isSearchingCity) {
      return AwesomeLoader(
          loaderType: AwesomeLoader.AwesomeLoader3, color: Colors.white);
    } else {
      return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: () {
          setState(() {
            isSearch = false;
          });
        },
      );
    }
  }

  loaderNavigationIcon() {
    if (isNavigationIconTapped) {
      return AwesomeLoader(
          loaderType: AwesomeLoader.AwesomeLoader3, color: Colors.white);
    } else {
      return refreshWeatherIcon();
    }
  }

  getWeatherUpdateEveryHour() {
    if (cityName.isEmpty) {
      getWeatherUpdate();
    } else {
      getWeatherUpdateByCity(cityName);
    }
  }
}
