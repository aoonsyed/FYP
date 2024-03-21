import 'dart:io';

import 'package:flutter/material.dart';

import 'result_screen.dart';
class ImageSelectedScreen extends StatefulWidget {
  File? image;
  ImageSelectedScreen({this.image});

  @override
  State<ImageSelectedScreen> createState() => _ImageSelectedScreenState();
}

class _ImageSelectedScreenState extends State<ImageSelectedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Selected",style: TextStyle(color: Colors.grey),)),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: widget.image!=null?Image.file(widget.image!,width: double.infinity,):null,
            ),
            SizedBox(height: 20,),
            ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green,maximumSize: Size(220, 40),minimumSize:Size(220, 40), ),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ResultScreen(image: widget.image)));
                }, child: Text("CLASSIFY",style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white) ,))

            // Expanded(flex:2,child: Container())
          ],
        ),
      ),
    );
  }
}
