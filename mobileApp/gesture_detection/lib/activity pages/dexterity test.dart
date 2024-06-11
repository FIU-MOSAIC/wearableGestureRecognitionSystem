import 'package:flutter/material.dart';

class DexterityTestPage extends StatelessWidget {
  const DexterityTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Dexterity Test'),
      ),
      body: const Center(
        child: Text('Dexterity Test Page'),
      ),
    );
  }
}