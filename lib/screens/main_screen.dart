import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../widgets/weather.dart';
import 'pages/home_page.dart';
import 'pages/new_test.dart';
import 'pages/user_manual.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  List screen = [
    HomePage(),
    NewTestScreen(),
    UserManual(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: screen[index],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.brown,
        animationCurve: Curves.linear,
        index: index,
        items: const [
          Icon(Icons.home, size: 40),
          Icon(Icons.camera_alt_rounded, size: 40),
          Icon(Icons.list_alt, size: 40),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
