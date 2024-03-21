import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Soil Sense",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                    padding: EdgeInsets.all(10),
                    color: Colors.grey.shade50,
                    child: Text(
                      "Identify soil type with your phone",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade50,
                    margin: EdgeInsets.only(
                        left: 20, right: 10, bottom: 10, top: 80),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Get Feature of soil (pH,NPK)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
          RotationTransition(
            turns: AlwaysStoppedAnimation(35 / 360),
            child: Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 300,
                child: Image.asset(
                  'assets/images/image2.png',
                )),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.grey.shade50,
                  margin:
                      EdgeInsets.only(left: 20, right: 10, bottom: 10, top: 10),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Get the suitable crop name according to soil type",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(flex: 1, child: Container())
            ],
          ),
        ],
      ),
    );
  }
}
