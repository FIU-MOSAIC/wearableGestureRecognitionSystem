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
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'In this project, students will develop a mobile/wearable app/service (for iOS, Android, and Fitbit devices) that provides hand motion instructions (either on the wearable or the phone) to a Fitbit user, which are then captured by the motion sensors of the wearable and sent back to the phone (and from there into a cloud service). '
                        'The purpose is to measure things such as hand dexterity, range of motion, reflexes, hand-eye coordination, etc., for individuals with motor impairments (e.g., due to a stroke). '
                        'In addition, a camera setup will be used to provide a reference for the hand/finger motions. Time permitting, the developed system will visualize the hand/fingers on the screen of the phone app or in a browser. '
                        'Students will work with smartphone development tools (most likely Google\'s Flutter development platform), the Fitbit API and SDK, and various server/web tools.',
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}