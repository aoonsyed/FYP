import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'image_selected.dart';
import 'dart:typed_data';

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
  String _pHResult = "";
  String _OMResult = "";

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/models/features.tflite');
    setState(() {
      _isModelLoaded = true;
    });
  }

  Future<void> performPrediction() async {
    if (!_isModelLoaded || widget.image == null) {
      print("Model not loaded or image is null.");
      return;
    }

    var imageBytes = img.decodeImage(File(widget.image!.path).readAsBytesSync());
    if (imageBytes == null) {
      print("Failed to decode image");
      return;
    }

    var imageResized = img.copyResize(imageBytes, width: 224, height: 224);
    var buffer = Float32List(1 * 224 * 224 * 3);
    var index = 0;
    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        var pixel = imageResized.getPixel(x, y);
        buffer[index++] = img.getRed(pixel) / 255.0;
        buffer[index++] = img.getGreen(pixel) / 255.0;
        buffer[index++] = img.getBlue(pixel) / 255.0;
      }
    }

    var input = buffer.reshape([1, 224, 224, 3]);
    var output = List.filled(1, List.filled(2, 0.0)); 

    _interpreter.run(input, output);

    // Fetching the pH and OM prediction results
    double pHValue = output[0][0];
    double OMValue = output[0][1]; // Get the OM prediction result
    setState(() {
      _pHResult = pHValue.toStringAsFixed(2); // Round to 2 decimal places
      _OMResult = OMValue.toStringAsFixed(2); // Round to 2 decimal places
      _showDialog(context, "pH Result: $_pHResult\nOM Result: $_OMResult");
    });
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Predicted Features",
            style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCropsDialog(BuildContext context, List<String> crops) {
    String cropsList = crops.join("\n");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Predicted Crops",
            style: TextStyle(color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Text(
              "Crops suitable for ${widget.soilType}:\n$cropsList",
              style: TextStyle(fontSize: 18),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void predictCropsBasedOnSoilType() {
    List<String> crops = [];
    switch (widget.soilType) {
      case "Clay Loam":
        crops = [
          "Corn",
          "Wheat",
          "Soybeans",
          "Potatoes",
          "Tomatoes",
          "Apples",
          "Cherries",
        ];
        break;
      case "Loam":
        crops = [
          "Beans (all types)",
          "Peas",
          "Carrots",
          "Lettuce",
          "Cabbage",
          "Peppers",
          "Squash",
          "Strawberries",
        ];
        break;
      case "Sandy Loam":
        crops = [
          "Melons (watermelon, cantaloupe)",
          "Peanuts",
          "Carrots",
          "Radishes",
          "Onions",
          "Peppers",
          "Sweet potatoes",
        ];
        break;
      case "Silt Loam":
        crops = [
          "Alfalfa",
          "Barley",
          "Peas",
          "Potatoes",
          "Spinach",
          "Sugar beets",
          "Wheat",
          "Lettuce",
        ];
        break;
      default:
        crops = ["No specific crops recommended for unidentified soil type"];
        break;
    }
    _showCropsDialog(context, crops);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Selected"),
        leading: BackButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ImageSelectedScreen(image: widget.image)),
           

            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                height: 300,
                width: double.infinity,
                child: widget.image != null ? Image.file(widget.image!, width: double.infinity) : null,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Soil Type: ${widget.soilType}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green), // Green color
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: performPrediction,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button color to green
                ),
                child: Text(
                  "PREDICT FEATURES",
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: predictCropsBasedOnSoilType,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set button color to green
                ),
                child: Text(
                  "PREDICT CROPS",
                  style: TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
