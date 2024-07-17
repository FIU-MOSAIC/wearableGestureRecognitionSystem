import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/results model.dart';

class ResultDetailPage extends StatelessWidget {
  final ExerciseResult result;

  const ResultDetailPage({super.key, required this.result});

  LineChartData buildChartData() {
    double minY = result.dataPoints.isNotEmpty
        ? result.dataPoints.map((e) => e.y).reduce((a, b) => a < b ? a : b)
        : -22;
    double maxY = result.dataPoints.isNotEmpty
        ? result.dataPoints.map((e) => e.y).reduce((a, b) => a > b ? a : b)
        : 22;

    return LineChartData(
      minX: 0,
      maxX: result.dataPoints.isNotEmpty
          ? result.dataPoints.last.x
          : 0,
      minY: minY,
      maxY: maxY,
      lineBarsData: [
        LineChartBarData(
          spots: result.dataPoints,
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
        title: Text(result.exerciseName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: LineChart(buildChartData()),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Test Date: ${DateFormat('MMM dd, yyyy - h:mm a').format(result.testDate)}',
              style: GoogleFonts.lato(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
