import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivityTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final double width;
  final void Function() onTap;
  

  const ActivityTile({
    required this.title,
    required this.imagePath,
    required this.width,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  Image.asset(
                    imagePath,
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
