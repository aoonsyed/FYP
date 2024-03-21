import 'package:flutter/material.dart';

class UserManual extends StatelessWidget {
  const UserManual({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Manual",
          style: TextStyle(color: Colors.grey),
        ),
        
      ),
      body: SingleChildScrollView(
        child: (Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1. Image Capture",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Real Time Images",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "• Navigate to click image section.\n• Ensure you device camera is enabled and properly working.\n• Point camera towards soil area you want to analyze.\n• The app will automatically process image for analysis.\n",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Select from Gallery",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "• Navigate to select from gallery.\n• Select the desired soil image from gallery.\n• App will initiate the image analysis",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "2. Image Analysis",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "• Once the soil image is captured or selected, soil sense utilize cutting-edge image processing algorithms to analyze various so 10/12 characteristics.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "3. Result Display",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "• After analysis Soil Sense presents result on user interface for easy interpretation.\n• Soil Types: Clearly states the identified soil type, providing user immediate insight to the soil's composition.\n• pH Value: Displays the pH value, indicating whether the soil is acidic, neutral or basic.\n• NPK Value: Presents nutrients levels (N,P,K) with corresponding values.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4. Crop Prediction",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "• Utilizing the analyzed soil data Soil Sense predicts suitable crops for cultivation, enhancing user decision making.\n• User receive a list of suggested crops, empowering them to make informed decisions for successful and the sustainable agricult",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
