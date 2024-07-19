import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class ExerciseResult {
  final String exerciseName;
  final DateTime testDate;
  final List<FlSpot>? dataPointsX;
  final List<FlSpot>? dataPointsY;
  final List<FlSpot>? dataPointsZ;
  final List<FlSpot>? dataPointsI;
  final List<FlSpot>? dataPointsJ;
  final List<FlSpot>? dataPointsK;

  ExerciseResult({
    required this.exerciseName,
    required this.testDate,
    this.dataPointsX,
    this.dataPointsY,
    this.dataPointsZ,
    this.dataPointsI,
    this.dataPointsJ,
    this.dataPointsK,
  });

  factory ExerciseResult.fromMap(Map<String, dynamic> map, String exerciseName) {

    List<FlSpot>? dataPointsX = (map['dataPointsX'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    List<FlSpot>? dataPointsY = (map['dataPointsY'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    List<FlSpot>? dataPointsZ = (map['dataPointsZ'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    List<FlSpot>? dataPointsI = (map['dataPointsI'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    List<FlSpot>? dataPointsJ = (map['dataPointsJ'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    List<FlSpot>? dataPointsK = (map['dataPointsK'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    return ExerciseResult(
      exerciseName: exerciseName,
      testDate: (map['testDate'] as Timestamp).toDate(),
      dataPointsX: dataPointsX,
      dataPointsY: dataPointsY,
      dataPointsZ: dataPointsZ,
      dataPointsI: dataPointsI,
      dataPointsJ: dataPointsJ,
      dataPointsK: dataPointsK,
    );
  }
}
