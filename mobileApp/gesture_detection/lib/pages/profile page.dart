import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/ProfileDropDown.dart';
import 'package:gesture_detection/components/ProfileTextField.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Profile Setup'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          const Icon(
            Icons.person,
            color: Colors.black,
            size: 100.0,
          ),
          Text(
            currentUser?.email?.split("@")[0] ?? "No email",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "My Details",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          const ProfileTextField(text: "Full Name", hintText: "Enter your full name"),
          const SizedBox(height: 20),
          const ProfileTextField(text: "Bio", hintText: "Enter your bio"),
          const SizedBox(height: 20),
          const ProfileTextField(text: "Age", hintText: "Enter your age", keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          GenderPicker()
        ],
      ),
    );
  }
}
