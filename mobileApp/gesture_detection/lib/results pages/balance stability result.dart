import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/pages/home%20page.dart';
import 'package:intl/intl.dart';  // Import intl to format dates

class BalanceStabilityResult extends StatelessWidget {
  const BalanceStabilityResult({super.key});

  Future<Map<String, dynamic>?> fetchLatestResult() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('balance_stability_results');
      var querySnapshot = await collection.orderBy('testDate', descending: true).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Balance and Stability Results'),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: fetchLatestResult(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data != null) {
            var data = snapshot.data!;
            var averageScore = (data['averageScore'] as double).round();  // Round the score to whole number
            var testDate = DateFormat('MMM dd, yyyy h:mm a').format(data['testDate'].toDate());  // Format the date with AM/PM and without seconds
            var message = averageScore > 80 ? "Great job! Keep it up!" : "Good effort! Let's aim higher next time.";

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Performance Result:\nAverage Score: $averageScore\nTest Date: $testDate',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    message,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: averageScore > 80 ? Colors.green : Colors.orange),
                  ),
                  const SizedBox(height: 60),
                  Button(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage()));
              },
              text: "Back to Home Page",
            ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('No results available'),
            );
          }
        },
      ),
    );
  }
}
