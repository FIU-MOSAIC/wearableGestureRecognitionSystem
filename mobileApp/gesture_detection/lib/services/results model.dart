import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseResult {
  final String exerciseName;
  final double averageScore;
  final DateTime testDate;

  ExerciseResult({
    required this.exerciseName,
    required this.averageScore,
    required this.testDate,
  });

  factory ExerciseResult.fromMap(Map<String, dynamic> map, String exerciseName) {
    return ExerciseResult(
      exerciseName: exerciseName,
      averageScore: map['averageScore'],
      testDate: (map['testDate'] as Timestamp).toDate(),
    );
  }
}
