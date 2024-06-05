import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SquareTile extends StatelessWidget{
  final String imagePath;
  void Function()? onTap;

  SquareTile ({super.key,
    required this.imagePath,
    required this.onTap});

  @override
  Widget build(BuildContext context) {
    //square for the google and apple button
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[200]),
        height: 90,
        child: Image.asset(imagePath),
      ),
    );
  }
}