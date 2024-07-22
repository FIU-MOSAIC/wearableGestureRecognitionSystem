import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const FormTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0), // padding on left and right
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white), // border color when not focused
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // border color when focused
          ),
          fillColor: Colors.white60, // background fill color
          filled: true,
          hintText: hintText, // hint text
          hintStyle: GoogleFonts.lato(color: Colors.grey), // hint text style
        ),
      ),
    );
  }
}
