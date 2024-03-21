import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HourlyWeather {
  final DateTime time;
  final double temperature;
  final String description;
  final String icon;

  HourlyWeather({
    required this.time,
    required this.temperature,
    required this.description,
    required this.icon,
  });
}

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  late List<HourlyWeather> hourlyWeather;

  @override
  void initState() {
    super.initState();
    // Fetch weather data on widget initialization
    fetchHourlyWeatherData();
    // Update weather data every hour
    Timer.periodic(Duration(hours: 1), (Timer timer) {
      fetchHourlyWeatherData();
    });
  }

  Future<void> fetchHourlyWeatherData() async {
    final String apiKey = '39f73e7a1c84e5bedff1c3dcbc62cfb5'; // Replace with your OpenWeatherMap API key
    final String city = 'Lahore';

    final String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> hourlyData = data['list'];

        setState(() {
          hourlyWeather = hourlyData.map((hourData) {
            return HourlyWeather(
              time: DateTime.fromMillisecondsSinceEpoch(hourData['dt'] * 1000),
              temperature: hourData['main']['temp'].toDouble(),
              description: hourData['weather'][0]['description'],
              icon: hourData['weather'][0]['icon'],
            );
          }).toList();
        });
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Implement your UI here using the fetched hourlyWeather data
    return hourlyWeather == null
          ? CircularProgressIndicator()
          : 
                Container(
                  height: 100,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24)
                  ),
                  child: Center(
                    child: ListTile(
                    title: Text('${hourlyWeather[0].time.hour}:00'),
                    subtitle: Text('${hourlyWeather[0].temperature}°C - ${hourlyWeather[0].description}'),
                    leading: Image.network('https://openweathermap.org/img/w/${hourlyWeather[0].icon}.png'),
                                    ),
                  ),);
  }
}
