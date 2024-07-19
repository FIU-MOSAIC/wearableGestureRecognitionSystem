import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/results model.dart';

class ResultDetailPage extends StatelessWidget {
  final ExerciseResult result;

  const ResultDetailPage({super.key, required this.result});

  double getMinY(List<FlSpot>? dataPoints) {
    if (dataPoints == null || dataPoints.isEmpty) {
      return 0;
    }
    return dataPoints.map((spot) => spot.y).reduce((value, element) => value < element ? value : element);
  }

  double getMaxY(List<FlSpot>? dataPoints) {
    if (dataPoints == null || dataPoints.isEmpty) {
      return 0;
    }
    return dataPoints.map((spot) => spot.y).reduce((value, element) => value > element ? value : element);
  }

  LineChartData buildChartData() {
    if (result.exerciseName == "Balance and Stability") {
      final minY = [
        getMinY(result.dataPointsX),
        getMinY(result.dataPointsY),
        getMinY(result.dataPointsZ)
      ].reduce((value, element) => value < element ? value : element);

      final maxY = [
        getMaxY(result.dataPointsX),
        getMaxY(result.dataPointsY),
        getMaxY(result.dataPointsZ)
      ].reduce((value, element) => value > element ? value : element);

      return LineChartData(
        minX: 0,
        maxX: result.dataPointsX != null && result.dataPointsX!.isNotEmpty ? result.dataPointsX!.last.x : 0,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          if (result.dataPointsX != null && result.dataPointsX!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsX!,
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsY != null && result.dataPointsY!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsY!,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsZ != null && result.dataPointsZ!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsZ!,
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
        ],
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true),
      );
    } else if (result.exerciseName == "Arm Mobility") {
      final minY = [
        getMinY(result.dataPointsI),
        getMinY(result.dataPointsJ),
        getMinY(result.dataPointsK)
      ].reduce((value, element) => value < element ? value : element);

      final maxY = [
        getMaxY(result.dataPointsI),
        getMaxY(result.dataPointsJ),
        getMaxY(result.dataPointsK)
      ].reduce((value, element) => value > element ? value : element);

      return LineChartData(
        minX: 0,
        maxX: result.dataPointsI != null && result.dataPointsI!.isNotEmpty ? result.dataPointsI!.last.x : 0,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          if (result.dataPointsI != null && result.dataPointsI!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsI!,
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsJ != null && result.dataPointsJ!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsJ!,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsK != null && result.dataPointsK!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsK!,
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
        ],
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true),
      );
    } else if (result.exerciseName == "Arm Rotation") {
      final minY = [
        getMinY(result.dataPointsX),
        getMinY(result.dataPointsY),
        getMinY(result.dataPointsZ)
      ].reduce((value, element) => value < element ? value : element);

      final maxY = [
        getMaxY(result.dataPointsX),
        getMaxY(result.dataPointsY),
        getMaxY(result.dataPointsZ)
      ].reduce((value, element) => value > element ? value : element);

      return LineChartData(
        minX: 0,
        maxX: result.dataPointsX != null && result.dataPointsX!.isNotEmpty ? result.dataPointsX!.last.x : 0,
        minY: minY,
        maxY: maxY,
        lineBarsData: [
          if (result.dataPointsX != null && result.dataPointsX!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsX!,
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsY != null && result.dataPointsY!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsY!,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          if (result.dataPointsZ != null && result.dataPointsZ!.isNotEmpty)
            LineChartBarData(
              spots: result.dataPointsZ!,
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
        ],
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: true),
      );
    } else {
      return LineChartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasData = (result.dataPointsX != null && result.dataPointsX!.isNotEmpty) ||
        (result.dataPointsY != null && result.dataPointsY!.isNotEmpty) ||
        (result.dataPointsZ != null && result.dataPointsZ!.isNotEmpty) ||
        (result.dataPointsI != null && result.dataPointsI!.isNotEmpty) ||
        (result.dataPointsJ != null && result.dataPointsJ!.isNotEmpty) ||
        (result.dataPointsK != null && result.dataPointsK!.isNotEmpty);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text(result.exerciseName),
      ),
      body: Center(
        child: hasData
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: LineChart(buildChartData()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (result.exerciseName == "Balance and Stability")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Accelerometer X', style: GoogleFonts.lato(fontSize: 14, color: Colors.red)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Accelerometer Y', style: GoogleFonts.lato(fontSize: 14, color: Colors.green)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Accelerometer Z', style: GoogleFonts.lato(fontSize: 14, color: Colors.blue)),
                        ),
                      ],
                    ),
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
                  if (result.exerciseName == "Arm Rotation")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Gyroscope X', style: GoogleFonts.lato(fontSize: 14, color: Colors.red)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Gyroscope Y', style: GoogleFonts.lato(fontSize: 14, color: Colors.green)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Gyroscope Z', style: GoogleFonts.lato(fontSize: 14, color: Colors.blue)),
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
              )
            : Text(
                'No data available',
                style: GoogleFonts.lato(fontSize: 16,
                fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
