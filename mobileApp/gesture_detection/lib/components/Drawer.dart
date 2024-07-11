import 'package:flutter/material.dart';
import 'package:gesture_detection/components/ListTile.dart';

class MyDrawer extends StatefulWidget {
  final void Function()? onProfileTap;
  final void Function()? onHistoryTap;
  final void Function()? onAboutUsTap;
  final void Function()? signOut;

  const MyDrawer({
    super.key,
    required this.onProfileTap,
    required this.onHistoryTap,
    required this.onAboutUsTap,
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
          MyListTile(
            icon: Icons.history,
            text: "H I S T O R Y",
            onTap: widget.onHistoryTap,
          ),
          MyListTile(
            icon: Icons.info,
            text: "A B O U T   U S",
            onTap: widget.onAboutUsTap,
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
