import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  final String title;
  const ActivityPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title + ' Instructions'),
      ),
      body: Center(
        child: Text('Activity Page'),
      ),
    );
  }
}