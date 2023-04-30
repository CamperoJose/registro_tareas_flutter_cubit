import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final Color primaryColor;

  CustomElevatedButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.primaryColor = Colors.red,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        primary: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
