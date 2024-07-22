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
      crossAxisAlignment: CrossAxisAlignment.start, // align children to the start of the column
      children: [
        GestureDetector(
          onTap: onTap, // handle tap events
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[300], // background color of the container
              borderRadius: BorderRadius.circular(20.0), // rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(7.0), // padding inside the container
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title, // display the title text
                      style: GoogleFonts.lato(
                        fontSize: 20.0, // font size of the title
                        fontWeight: FontWeight.bold, // bold font weight
                        color: Colors.grey[600], // text color
                      ),
                    ),
                  ),
                  const SizedBox(width: 20.0), // spacing between text and image
                  Image.asset(
                    imagePath, // display the image from assets
                    width: 50,
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0), // space below the tile
      ],
    );
  }
}
