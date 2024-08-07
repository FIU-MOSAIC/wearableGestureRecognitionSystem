import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap; 

  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0), // padding around the list tile
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        title: Text(
          text,
          style: GoogleFonts.lato(color: Colors.white, fontSize: 15),
        ),
        onTap: onTap, // handle tap events
      ),
    );
  }
}
