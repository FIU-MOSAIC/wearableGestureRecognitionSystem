import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Drawer.dart';
import 'package:gesture_detection/pages/profile page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
// test for the merged branch 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sign out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage() {
    // Pop the drawer
    Navigator.pop(context);
    // Go to profile page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        signOut: signUserOut,
        onProfileTap: goToProfilePage,
      ),
      body: const Center(child: Text('logged in')),
    );
  }
}
