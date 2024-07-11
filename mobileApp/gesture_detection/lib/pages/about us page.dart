import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('About Us Page'),
      ),
    );
  }
}