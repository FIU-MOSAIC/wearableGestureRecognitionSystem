import 'package:flutter/material.dart';

class ActivityInstructionPage extends StatelessWidget {
  final String title;
  const ActivityInstructionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text(title + ' Instructions'),
      ),
      body:
       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 20.0),
         child: ListView(
          children: [
            const SizedBox(height: 20),
            Text("Description:",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),),
            const SizedBox(height: 20),
            Text('Step by step instructions on how to complete the activity.'),
            Text('Tips for proper execution. ')
            
          ],
        ),
      )
    );
  }
}