import 'package:flutter/material.dart';
class ButtonWidget extends StatelessWidget {
  FontWeight? fontWeight;
  String buttonData;
  double? fontSize;
  Color? color;
  Color? buttoncolor;
  Widget screen;

  ButtonWidget({required this.buttonData,this.fontWeight, this.fontSize, this.color, this.buttoncolor,required this.screen});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: buttoncolor,maximumSize: Size(220, 40),minimumSize:Size(220, 40), ),
        onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>screen));
    }, child: Text(buttonData,style:TextStyle(fontSize: fontSize,fontWeight: fontWeight,color: color) ,));
  }
}
