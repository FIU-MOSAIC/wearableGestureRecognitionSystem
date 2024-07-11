import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../results pages/balance stability result.dart';

class BalanceStabilityPage extends StatefulWidget {
  const BalanceStabilityPage({super.key});

  @override
  _BalanceStabilityPageState createState() => _BalanceStabilityPageState();
}

class _BalanceStabilityPageState extends State<BalanceStabilityPage> {
  late WebSocketChannel channel;
  Timer? timer;
  DateTime? startTime;
  double durationInSeconds = 0;
  List<double> scores = []; // Store scores here
  bool _isSaving = false;

  double accelX = 0.0, accelY = 0.0, accelZ = 0.0;
  double gyroX = 0.0, gyroY = 0.0, gyroZ = 0.0;
  double heartRate = 0.0;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.0.47:8080');
    channel.stream.listen((data) {
      setState(() {
        Map<String, dynamic> decodedData = jsonDecode(data);
        accelX = decodedData['accelX'].last.toDouble();
        accelY = decodedData['accelY'].last.toDouble();
        accelZ = decodedData['accelZ'].last.toDouble();
        gyroX = decodedData['gyroX'].last.toDouble();
        gyroY = decodedData['gyroY'].last.toDouble();
        gyroZ = decodedData['gyroZ'].last.toDouble();
        heartRate = decodedData['heartRate'].last.toDouble().round().toDouble();

        // Start timer if significant change detected and timer not already started
        if (startTime == null && timer == null && accelX != 0) {
          startTime = DateTime.now();
          timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
            updateDuration();
            updateScore();
          });
        }
      });
    });
  }

  void updateDuration() {
    if (startTime != null) {
      final now = DateTime.now();
      setState(() {
        durationInSeconds = now.difference(startTime!).inSeconds.toDouble();
      });
    }
  }

  void updateScore() {
    double stabilityScore = (1.0 - ((accelX.abs() + accelY.abs() + gyroZ.abs()) / 3.0)) * 120;
    stabilityScore = stabilityScore.clamp(0, 100); // Ensure score is between 0 and 100
    scores.add(stabilityScore); // Add the score to the list
  }

  double computeAverageScore() {
    if (scores.isEmpty) return 0;
    return scores.reduce((a, b) => a + b) / scores.length;
  }

  @override
  void dispose() {
    timer?.cancel();
    scores.clear(); // Clear the scores list
    channel.sink.close();
    super.dispose();
  }

  void saveResults() async {
    setState(() {
      _isSaving = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    double averageScore = computeAverageScore();
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Balance_and_Stability_Results').add({
        'averageScore': averageScore,
        'duration': durationInSeconds,
        'testDate': DateTime.now(),
      }).then((value) {
        print("Result Added");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BalanceStabilityResult()));
      }).catchError((error) {
        print("Failed to add result: $error");
      }).whenComplete(() {
        setState(() {
          _isSaving = false;
          scores.clear(); // Clear the scores after saving
        });
      });
    } else {
      print('No user logged in');
    }
  }

  Widget buildStabilityIndicator() {
    double stabilityScore = scores.isNotEmpty ? scores.last : 0;
    int stabilityScoreInt = stabilityScore.round();
    String feedbackMessage = stabilityScoreInt > 80 ? 'Keep steady' : 'Find the middle point';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Stability Score: $stabilityScoreInt%',
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        LinearProgressIndicator(
          value: stabilityScoreInt / 100,
          backgroundColor: Colors.red,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        const SizedBox(height: 20),
        Text(
          'Heart Rate: ${heartRate.round()} BPM',
          style: GoogleFonts.lato(fontSize: 24),
        ),
        const SizedBox(height: 20),
        Text(
          feedbackMessage,
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold, color: feedbackMessage == 'Keep steady' ? Colors.green : Colors.red),
        ),
        const SizedBox(height: 20),
        Text(
          'Duration: ${durationInSeconds.toStringAsFixed(0)} seconds',
          style: GoogleFonts.lato(fontSize: 20),
        ),
        const SizedBox(height: 80),
        if (!_isSaving)
          Button(
            onTap: () {
              if (timer != null && timer!.isActive) {
                timer!.cancel();
                timer = null;
              }
              saveResults();
            },
            text: "Save and See Results",
          ),
        if (_isSaving) const CircularProgressIndicator(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Balance and Stability Exercise'),
      ),
      body: Center(
        child: buildStabilityIndicator(),
      ),
    );
  }
}
