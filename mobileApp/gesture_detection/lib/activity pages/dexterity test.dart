import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class DexterityTestPage extends StatefulWidget {
  const DexterityTestPage({super.key});

  @override
  _DexterityTestPageState createState() => _DexterityTestPageState();
}

class _DexterityTestPageState extends State<DexterityTestPage> {
  late WebSocketChannel channel;
  Map<String, dynamic> receivedData = {
    "accelX": [],
    "accelY": [],
    "accelZ": [],
    "gyroX": [],
    "gyroY": [],
    "gyroZ": [],
    "orientationScalar": [],
    "orientationI": [],
    "orientationJ": [],
    "orientationK": []
  };
  String instructions = 'Touch your index finger to your thumb.';
  double dexterityScore = 0;
  int touchCount = 0;

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.0.13:8081');
    channel.stream.listen((data) {
      setState(() {
        receivedData = jsonDecode(data);
        // Calculate dexterity score or other metrics here based on received data
        dexterityScore = calculateDexterityScore(receivedData);
        touchCount = countTouches(receivedData);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Dexterity Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(instructions, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Dexterity Score: $dexterityScore', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Touch Count: $touchCount', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Accelerometer Data', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: LineChart(LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: _createSpots(receivedData['accelX']),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                  LineChartBarData(
                    spots: _createSpots(receivedData['accelY']),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                  LineChartBarData(
                    spots: _createSpots(receivedData['accelZ']),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                ],
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                lineTouchData: LineTouchData(enabled: false),
              )),
            ),
            SizedBox(height: 20),
            Text('Gyroscope Data', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: LineChart(LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: _createSpots(receivedData['gyroX']),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                  LineChartBarData(
                    spots: _createSpots(receivedData['gyroY']),
                    isCurved: true,
                    color: Colors.green,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                  LineChartBarData(
                    spots: _createSpots(receivedData['gyroZ']),
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 2,
                    isStrokeCapRound: true,
                  ),
                ],
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                lineTouchData: LineTouchData(enabled: false),
              )),
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _createSpots(List<dynamic> data) {
    return data.asMap().entries.map((entry) {
      int idx = entry.key;
      double value = entry.value.toDouble();
      return FlSpot(idx.toDouble(), value);
    }).toList();
  }

  double calculateDexterityScore(Map<String, dynamic> data) {
    double accelMagnitude = 0;
    if (data['accelX'].isNotEmpty) {
      accelMagnitude = sqrt(data['accelX'].last.toDouble() * data['accelX'].last.toDouble() +
                            data['accelY'].last.toDouble() * data['accelY'].last.toDouble() +
                            data['accelZ'].last.toDouble() * data['accelZ'].last.toDouble());
    }
    return accelMagnitude;
  }

  int countTouches(Map<String, dynamic> data) {
    int count = 0;
    double threshold = 2.0; // Adjust threshold based on experimentation
    double previousMagnitude = 0;
    bool isTouching = false;

    if (data['accelX'].length > 1) {
      for (int i = 1; i < data['accelX'].length; i++) {
        double deltaX = data['accelX'][i] - data['accelX'][i - 1];
        double deltaY = data['accelY'][i] - data['accelY'][i - 1];
        double deltaZ = data['accelZ'][i] - data['accelZ'][i - 1];
        double magnitude = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ);

        if (magnitude > threshold && !isTouching) {
          isTouching = true;
          count++;
        } else if (magnitude < threshold) {
          isTouching = false;
        }
        previousMagnitude = magnitude;
      }
    }
    return count;
  }
}
