import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const Button({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // handle tap events
      child: Container(
        padding: const EdgeInsets.all(25.0), // padding inside the container
        margin: const EdgeInsets.symmetric(horizontal: 25), // margin on the sides
        decoration: BoxDecoration(
          color: Colors.black, // background color of the container
          borderRadius: BorderRadius.circular(8), // rounded corners
        ),
        child: Center(
          child: Text(
            text, // display the button text
            style: GoogleFonts.lato(
              color: Colors.white, // text color
              fontWeight: FontWeight.bold, // bold font weight
              fontSize: 16, // font size
            ),
          ),
        ),
      ),
    );
  }
}
