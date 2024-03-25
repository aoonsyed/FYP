import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'image_selected.dart';
import 'predict_crops.dart';

class ResultScreen extends StatefulWidget {
  final File? image;
  final String soilType;

  ResultScreen({this.image, this.soilType = "Unidentified"});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;
  String _predictionResult = "";

  @override
  void initState() {
    super.initState();
    loadModel();
    // Log the soil type to the console.
    print("Soil Type: ${widget.soilType}");
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/features.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> performPrediction() async {
    if (!_isModelLoaded || widget.image == null) return;

    var imageBytes = img.decodeImage(File(widget.image!.path).readAsBytesSync());
    var imageResized = img.copyResize(imageBytes!, width: 224, height: 224);
    List<double> imageAsList = imageResized.data.buffer.asUint8List().map((i) => i.toDouble()).toList();

    var input = imageAsList.reshape([1, 224, 224, 3]);
    List<double> output = List.filled(1, 0);

    _interpreter.run(input, output);

    // Log the prediction result to the console.
    print("Prediction Result: $output");

    setState(() {
      _predictionResult = output[0].toString();
    });
  }

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
                "Soil Type: ${widget.soilType}",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                  maximumSize: Size(220, 40),
                  minimumSize: Size(220, 40),
                ),
                onPressed: performPrediction,
                child: Text(
                  "CHECK FEATURES",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                )),
            SizedBox(height: 20),
            if (_predictionResult.isNotEmpty)
              Text(
                "Prediction Result: $_predictionResult",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            SizedBox(height: 20),
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
