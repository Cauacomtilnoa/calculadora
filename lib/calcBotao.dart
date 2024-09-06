import 'package:flutter/material.dart';

Widget calcButton(
  String buttonText, Color buttonColor, void Function()? buttonPressed) {
  return Container(
    height: 70,
    width: buttonText == "=" ? 180 : 75,
    
    child: ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(23))),
        backgroundColor: buttonColor
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}