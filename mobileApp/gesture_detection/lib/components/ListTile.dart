import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap; // Added onTap as a class variable

  const MyListTile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap, // Assign onTap to the class variable
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
          size: 30.0,
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        onTap: onTap, // Use the onTap function in ListTile
      ),
    );
  }
}