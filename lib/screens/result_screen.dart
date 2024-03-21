import 'dart:io';

import 'package:flutter/material.dart';

import 'feature_check_screen.dart';
import 'image_selected.dart';
import 'predict_crops.dart';

class ResultScreen extends StatefulWidget {
  final File? image;
  final String soilType;

  ResultScreen({this.image, this.soilType = "Unidentified"}); // Default soil type to "Unidentified"

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Image Selected",
          style: TextStyle(color: Colors.grey),
        ),
        leading: BackButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ImageSelectedScreen(image: widget.image),
              ),
            );
          },
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 300,
              width: double.infinity,
              child: widget.image != null
                  ? Image.file(
                      widget.image!,
                      width: double.infinity,
                    )
                  : null,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.soilType, // Display the soil type passed to this screen
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  maximumSize: Size(220, 40),
                  minimumSize: Size(220, 40),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeatureCheckScreen(image: widget.image),
                    ),
                  );
                },
                child: Text(
                  "CHECK FEATURES",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  maximumSize: Size(220, 40),
                  minimumSize: Size(220, 40),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PredictCropScreen(image: widget.image),
                    ),
                  );
                },
                child: Text(
                  "PREDICTED CROPS",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
