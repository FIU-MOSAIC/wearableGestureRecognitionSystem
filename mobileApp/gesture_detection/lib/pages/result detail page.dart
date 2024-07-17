import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/results model.dart';

class ResultDetailPage extends StatelessWidget {
  final ExerciseResult result;

  const ResultDetailPage({super.key, required this.result});

  LineChartData buildBalanceChartData() {
    return LineChartData(
      minX: 0,
      maxX: result.dataPoints.isNotEmpty ? result.dataPoints.last.x : 0,
      minY: -22,
      maxY: 22,
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

  LineChartData buildArmMobilityChartData() {
    return LineChartData(
      minX: 0,
      maxX: result.dataPointsI != null && result.dataPointsI!.isNotEmpty
          ? result.dataPointsI!.last.x
          : 0,
      minY: -1,
      maxY: 1,
      lineBarsData: [
        LineChartBarData(
          spots: result.dataPointsI!,
          isCurved: true,
          color: Colors.red,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: result.dataPointsJ!,
          isCurved: true,
          color: Colors.green,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        LineChartBarData(
          spots: result.dataPointsK!,
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
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
                child: LineChart(
                  result.exerciseName == "Balance and Stability"
                      ? buildBalanceChartData()
                      : buildArmMobilityChartData(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (result.exerciseName == "Arm Mobility")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text('Orientation I', style: GoogleFonts.lato(fontSize: 14, color: Colors.red)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text('Orientation J', style: GoogleFonts.lato(fontSize: 14, color: Colors.green)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text('Orientation K', style: GoogleFonts.lato(fontSize: 14, color: Colors.blue)),
                  ),
                ],
              ),
            Text(
              'Test Date: ${DateFormat('MMM dd, yyyy - h:mm a').format(result.testDate)}',
              style: GoogleFonts.lato(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
