import 'package:flutter/material.dart';

import 'main_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;
  List data = [
    {
      "title": "Welcome to TerraView",
      "description":
          "Slide through diverse soil types, unravel key features and harness the predictive power for smarter farming decisions."
    },
    {
      "title": "TerraView is your ally in precision agriculture",
      "description":
          "Explore soil types effortlessly decode distinctive features and receive personalized crop prediction."
    },
    {
      "title": "Step into the future of agriculture",
      "description":
          "This app is your key to unlocking the full potential of your farm."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return HomeScreen();
              },
            ));
          },
          child: Text(
            "Skip",
            style: TextStyle(color: Colors.grey,
            fontSize: 25.0),
          ),
        ),
      ]),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemCount: data.length,
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 300,
                      child: Image.asset('assets/images/image1.png')),
                  
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        data[index]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          color: Color.fromARGB(1000, 69, 132, 27),
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        data[index]["description"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Colors.black),
                      )),
                ],
              );
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List<Widget>.generate(
                          data.length, (index) => buildDot(index, context)),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        pageController.nextPage(
                            duration: Duration(microseconds: 200),
                            curve: Curves.linearToEaseOut);
                        if (currentIndex == data.length - 1) {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return HomeScreen();
                            },
                          ));
                        }
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 35,
                        color: Colors.white,
                      ),
                      backgroundColor: Color.fromRGBO(69, 132, 27, 1),
                      shape: CircleBorder(),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 10,
      width: currentIndex == index ? 25 : 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(69, 132, 27, 1),
      ),
    );
  }
}
