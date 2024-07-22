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
    // convert map data to list of flspot objects for data points x
    List<FlSpot>? dataPointsX = (map['dataPointsX'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // convert map data to list of flspot objects for data points y
    List<FlSpot>? dataPointsY = (map['dataPointsY'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // convert map data to list of flspot objects for data points z
    List<FlSpot>? dataPointsZ = (map['dataPointsZ'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // convert map data to list of flspot objects for data points i
    List<FlSpot>? dataPointsI = (map['dataPointsI'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // convert map data to list of flspot objects for data points j
    List<FlSpot>? dataPointsJ = (map['dataPointsJ'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // convert map data to list of flspot objects for data points k
    List<FlSpot>? dataPointsK = (map['dataPointsK'] as List?)
        ?.map((point) => FlSpot(
            (point['x'] as num).toDouble(), (point['y'] as num).toDouble()))
        .toList();

    // create exerciseresult instance from map data
    return ExerciseResult(
      exerciseName: exerciseName,
      testDate: (map['testDate'] as Timestamp).toDate(), // convert timestamp to datetime
      dataPointsX: dataPointsX,
      dataPointsY: dataPointsY,
      dataPointsZ: dataPointsZ,
      dataPointsI: dataPointsI,
      dataPointsJ: dataPointsJ,
      dataPointsK: dataPointsK,
    );
  }
}
