import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text('Profile Page'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          const Icon(
            Icons.person,
            color: Colors.black,
            size: 100.0,
          ),
        Text(currentUser.email!.split("@")[0],
        textAlign: TextAlign.center,
        ),
      ],
      ),
    );
  }
}