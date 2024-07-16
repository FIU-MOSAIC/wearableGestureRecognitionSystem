import 'package:flutter/material.dart';

class RangeOfMotionTestPage extends StatelessWidget {
  const RangeOfMotionTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Range of Motion Test'),
      ),
      body: const Center(
        child: Text('Range of Motion Test Page'),
      ),
    );
  }
}
