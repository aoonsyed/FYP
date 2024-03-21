import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens/about.dart';
import '../screens/main_screen.dart';
class BottomNabBar extends StatefulWidget {
  const BottomNabBar({super.key});

  @override
  State<BottomNabBar> createState() => _BottomNabBarState();
}

class _BottomNabBarState extends State<BottomNabBar> {
  int currentIndex=0;
  List screen=[
    HomeScreen(),
    AboutScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:CurvedNavigationBar(
          backgroundColor: Colors.grey,
          buttonBackgroundColor: Colors.white,
          color: Colors.grey,
          index: currentIndex,
          items: [
            Icon(Icons.home,size: 40,),
            Icon(Icons.camera_alt_rounded,size: 40,),
            Icon(Icons.list_alt,size: 40,),
          ],
          onTap: (index) {
            setState(() {
              currentIndex=index;
            });
          },
        ),
      body: screen[currentIndex],
    );
  }
}
