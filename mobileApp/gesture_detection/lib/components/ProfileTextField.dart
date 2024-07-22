import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const ProfileTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 12.0), // padding for the text label
            child: Text(
              text,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        const SizedBox(width: 40), // space between the label and the text field
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0), // padding for the text field
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText, // hint text for the text field
                hintStyle: GoogleFonts.lato(color: Colors.black),
                focusedBorder: InputBorder.none, // no border when focused
              ),
            ),
          ),
        ),
      ],
    );
  }
}
