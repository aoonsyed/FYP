import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import 'screens/main_screen.dart';
import 'screens/onboard_screen.dart';

void main() => runApp(MaterialApp(home: MyApp()));

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.brown,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.green,
    background: Colors.white,
  ),
  appBarTheme: AppBarTheme(centerTitle: true, toolbarHeight: 65, ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.primary,
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: appTheme,
      home: OnBoardingScreen(),
    );
  }
}



