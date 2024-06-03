import 'package:flutter/material.dart';
import 'package:gesture_detection/components/ListTile.dart';

class MyDrawer extends StatefulWidget {
  final void Function()? onProfileTap;
  final void Function()? signOut;

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.signOut,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 100.0),
          const Icon(
            Icons.home,
            color: Colors.white,
            size: 64,
          ),
          const SizedBox(height: 50.0),
          MyListTile(
            icon: Icons.person,
            text: "P R O F I L E",
            onTap: widget.onProfileTap,
          ),
          const MyListTile(
            icon: Icons.run_circle,
            text: "A C T I V I T Y",
          ),
          const MyListTile(
            icon: Icons.contacts,
            text: "A B O U T   U S",
          ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyListTile(
              icon: Icons.logout,
              text: "L O G   O U T",
              onTap: widget.signOut,
            ),
          ),
        ],
      ),
    );
  }
}