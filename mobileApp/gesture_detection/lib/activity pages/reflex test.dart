import 'package:flutter/material.dart';

class ReflexTestPage extends StatelessWidget {
  const ReflexTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Reflex Test'),
      ),
      body: const Center(
        child: Text('Reflex Test Page'),
      ),
    );
  }
}//