import 'dart:io';

import 'package:flutter/material.dart';
import 'image_selected.dart';
import 'result_screen.dart';

class PredictCropScreen extends StatefulWidget {
  File? image;

  PredictCropScreen({this.image});

  @override
  State<PredictCropScreen> createState() => _PredictCropScreenState();
}

class _PredictCropScreenState extends State<PredictCropScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Result",
            style: TextStyle(color: Colors.grey),
          ),
          leading: BackButton(
            color: Colors.green,
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(image: widget.image),
                  ));
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
              "Silt Loam",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
        SizedBox(
          height: 40,
        ),
        Text(
          "CHECK FEATURES",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
    SizedBox(
    height: 20,
    ),
    Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    color: Colors.grey.shade100,
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text("Predicted Crops",style: TextStyle(fontWeight: FontWeight.bold),),
    Container(
    padding: EdgeInsets.all(20),
    child: Text("Suitable crops like, wheat, corn, barley,beans, Patatos Radish ets"),
    )


    ],
    ),
    ),
    ],
    )
    ,
    )
    ,
    );
  }
}
