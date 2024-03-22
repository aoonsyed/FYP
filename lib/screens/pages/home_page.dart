import 'package:flutter/material.dart';
import 'package:soil_sense/screens/pages/consts.dart';
import 'package:weather/weather.dart';

import '../../widgets/button.dart';
import '../about.dart';
import 'user_manual.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherFactory _weatherFactory=WeatherFactory(WEATHER_API_KEY);
  late Weather _weather;
  @override
  void initState() {
    super.initState();
    _weatherFactory.currentWeatherByCityName("Narowal").then((W){
      setState(() {
        _weather=W;
      });
    } );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_weather?.areaName??" ",style: TextStyle(fontSize: 20),),
            Container(
              height: 90,
              width: 90,
              child: Image(image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),),
            ),
            Text("${_weather.temperature?.celsius!.toStringAsFixed(0)} c",style: TextStyle(fontSize: 30),),
            SizedBox(height: 30),
            Container(
                height: 150, child: Image.asset('assets/images/image1.png')),
            RichText(
                text: TextSpan(
                    text: "Soil",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                    children: [
                      TextSpan(
                          text: "Sense",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown))
                    ])),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Welcome to soil sense",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 25,
            ),
            CustomButton(
              label: 'User Manual',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UserManual()));
              },
            ),
            const SizedBox(
              height: 25,
            ),
            CustomButton(
              label: 'About',
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AboutScreen()));
              },
            ),
            // ButtonWidget(
            //   buttonData: "ABOUT SOIL SENSE",
            //   color: Colors.white,
            //   fontWeight: FontWeight.bold,
            //   fontSize: 15,
            //   buttoncolor: Colors.brown,screen: UserManual()),),
            // Container(margin: EdgeInsets.only(top: 10),
            //   child: ButtonWidget(
            //     buttonData: "NEW TEST",
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 15,
            //     buttoncolor: Colors.brown,screen: NewTestScreen(),
            //     ),
            //     ),
          ],
        ),
      ),
    );
  }
}

