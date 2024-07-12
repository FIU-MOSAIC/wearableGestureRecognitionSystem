import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[900],
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: Center(
              child: Image.asset(
                'lib/images/mosaic-logo.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }
}