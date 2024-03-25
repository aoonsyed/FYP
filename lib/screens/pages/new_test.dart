import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img1;

import '../../widgets/button.dart';
import '../result_screen.dart';

class NewTestScreen extends StatefulWidget {
  @override
  _NewTestScreenState createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  late Interpreter _interpreter;
  bool isImageSelected = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(
        'assets/models/mobilenet_v2_soil_classification.tflite');
  }

  Future<void> selectImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        isImageSelected = true;
      });
    }
  }

  void classifyImage() async {
    if (imageFile == null) {
      // Show error dialog if no image is selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Classification Error"),
            content: Text("Please select an image to classify."),
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
      return;
    }

    // Load and preprocess the image
    img1.Image image = img1.decodeImage(await imageFile!.readAsBytes())!;
    img1.Image resizedImg = img1.copyResize(image, width: 224, height: 224);
    var input = imageToByteListFloat32(resizedImg, 224, 127.5, 127.5);

    // Run model on image
    var output = List.filled(1 * 5, 0)
        .reshape([1, 5]); // Adjust based on your model's output
    _interpreter.run(input, output);

    // Interpret model output as probabilities
    final List<double> probabilities = output[0].cast<double>();

    // Find the index of the class with the highest probability
    final predictedIndex = probabilities.indexOf(probabilities.reduce(max));

    // Map the index to the corresponding soil type label
    final List<String> soilTypes = [
      'Clay Loam',
      'Loam',
      'Unidentified',
      'Sandy Loam',
      'Silt Loam'
    ];
    final predictedLabel = soilTypes[predictedIndex];

    // Show fancy dialog with classification result
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Classification Result"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Soil Type is:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                predictedLabel,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultScreen(
                      image: imageFile,
                      soilType: predictedLabel,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Uint8List imageToByteListFloat32(
      img1.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);

        buffer[pixelIndex++] = (img1.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img1.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img1.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Classify Soil",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: isImageSelected
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (imageFile != null)
                          Container(
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                              child: Image.file(
                                imageFile!,
                                fit: BoxFit.fill,
                              )),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: classifyImage,
                          child: Text("Classify Image"),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton(
                            label: 'Take Photo',
                            onTap: () => selectImage(ImageSource.camera)),
                        SizedBox(height: 20),
                        CustomButton(
                            label: 'Pick from Gallery',
                            onTap: () => selectImage(ImageSource.gallery))
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _interpreter.close();
    super.dispose();
  }
}
