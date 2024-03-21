import 'package:flutter/material.dart';

import '../../widgets/button.dart';
import '../about.dart';
import 'user_manual.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // WeatherWidget(),
            const SizedBox(height: 30),
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
