import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String text;
  final String hintText;
  final TextInputType keyboardType;  // Added this line

  // Updated constructor to include keyboardType with a default value
  const ProfileTextField({
    super.key,
    required this.text,
    required this.hintText,
    this.keyboardType = TextInputType.text,  // Default to text input
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              keyboardType: keyboardType,  // Apply keyboardType to TextField
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey[500]),
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}