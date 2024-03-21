import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.label,
    required this.onTap,
    super.key,
  });
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        width: 200,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.brown),
      ),
    );
  }
}
