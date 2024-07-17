import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../pages/home page.dart';

class BalanceStabilityResult extends StatelessWidget {
  const BalanceStabilityResult({super.key});

  Future<Map<String, dynamic>?> fetchLatestResult() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var collection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('Balance_and_Stability_Results');
      var querySnapshot = await collection.orderBy('testDate', descending: true).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data();
      }
    }
    return null;
  }

  LineChartData buildChartData(List<FlSpot> dataPoints, double durationInSeconds) {
    double minY = dataPoints.isNotEmpty ? dataPoints.map((e) => e.y).reduce((a, b) => a < b ? a : b) : -22;
    double maxY = dataPoints.isNotEmpty ? dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b) : 22;

    return LineChartData(
      minX: 0,
      maxX: durationInSeconds,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: dataPoints,
          isCurved: true,
          color: Colors.blue,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: true),
    );
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
            List<FlSpot> dataPoints = (data['dataPoints'] as List)
                .map((point) => FlSpot((point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
                .toList();
            double durationInSeconds = data['duration'] as double;
            var testDate = DateFormat('MMM dd, yyyy h:mm a').format(data['testDate'].toDate());

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: LineChart(buildChartData(dataPoints, durationInSeconds)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Test Date: $testDate',
                    style: GoogleFonts.lato(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    },
                    text: "Back to Home Page",
                  ),
                  const SizedBox(height: 45),
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
