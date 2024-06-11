import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SquareTile extends StatelessWidget {
  final String imagePath;
  final double size; // Add the size parameter
  void Function()? onTap;

  SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
    required this.size, // Initialize the size parameter
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[300],
        ), // Use the size parameter for width
        height: size, // Use the size parameter for height
        child: Image.asset(imagePath),
      ),
    );
  }
}
