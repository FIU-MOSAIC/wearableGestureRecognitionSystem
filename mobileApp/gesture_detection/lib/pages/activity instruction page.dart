import 'package:flutter/material.dart';

class ActivityInstructionPage extends StatelessWidget {
  final String title;
  const ActivityInstructionPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title + ' Instructions'),
      ),
      body: Center(
        child: Text('Instruction Page'),
      ),
    );
  }
}