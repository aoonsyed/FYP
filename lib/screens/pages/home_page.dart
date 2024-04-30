import 'package:flutter/material.dart';
import 'package:soil_sense/screens/pages/consts.dart';
import 'package:weather/weather.dart';

import '../../widgets/button.dart';
import '../about.dart';
import 'user_manual.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherFactory _weatherFactory = WeatherFactory(WEATHER_API_KEY);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final weather = await _weatherFactory.currentWeatherByCityName("Narowal");
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("Error fetching weather data: $e");
      // Handle the error here, e.g., show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoilSense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown,
          title: Center(
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Center(
          child: _weather == null
              ? CircularProgressIndicator() // Show a loading indicator
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_weather!.areaName ?? " ", style: TextStyle(fontSize: 20)),
                    Container(
                      height: 110,
                      width: 110,
                      child: Image(
                        image: NetworkImage(
                            "https://openweathermap.org/img/wn/${_weather!.weatherIcon}@4x.png"),
                      ),
                    ),
                    Text(
                      "${_weather!.temperature?.celsius!.toStringAsFixed(0)} c",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 15),
                    Container(height: 200, child: Image.asset('assets/images/image1.png')),
                    Text(
                      "Welcome to TerraView",
                      style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      label: 'User Manual',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserManual()));
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomButton(
                      label: 'About',
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AboutScreen()));
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
