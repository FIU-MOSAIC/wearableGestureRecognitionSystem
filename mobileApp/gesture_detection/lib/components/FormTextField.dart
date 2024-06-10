import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormTextField extends StatelessWidget{
  final controller;
  final String hintText;
  final bool obscureText;

  const FormTextField ({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText});


  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),
          fillColor: Colors.white60,
          filled: true,
          hintText: hintText,
          hintStyle: GoogleFonts.lato(color: Colors.grey)
        ),
      ),
    );
  }
}
