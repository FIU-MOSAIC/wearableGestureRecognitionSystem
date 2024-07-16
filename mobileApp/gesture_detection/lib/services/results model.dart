import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class ExerciseResult {
  final String exerciseName;
  final DateTime testDate;
  final List<FlSpot> dataPoints;

  ExerciseResult({
    required this.exerciseName,
    required this.testDate,
    required this.dataPoints,
  });

  factory ExerciseResult.fromMap(Map<String, dynamic> map, String exerciseName) {
    List<FlSpot> dataPoints = (map['dataPoints'] as List)
        .map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    return ExerciseResult(
      exerciseName: exerciseName,
      testDate: (map['testDate'] as Timestamp).toDate(),
      dataPoints: dataPoints,
    );
  }
}
