import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text('History Page'),
      ),
    );
  }
}