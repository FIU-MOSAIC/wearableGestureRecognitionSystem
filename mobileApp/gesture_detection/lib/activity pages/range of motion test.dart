import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:fl_chart/fl_chart.dart';

import '../components/Button.dart';

class RangeOfMotionTestPage extends StatefulWidget {
  const RangeOfMotionTestPage({super.key});

  @override
  _RangeOfMotionTestPageState createState() => _RangeOfMotionTestPageState();
}

class _RangeOfMotionTestPageState extends State<RangeOfMotionTestPage>{
  late WebSocketChannel channel;
  Timer? timer;
  late Stopwatch stopwatch;
  DateTime? startTime;
  double durationInSeconds = 0;
  late double largest = 0;
  late double smallest = 0;

  double currentAccelX = 0.0, currentAccelY = 0.0, currentAccelZ = 0.0;
  double currentGyroX = 0.0, currentGyroY = 0.0, currentGyroZ = 0.0;
  double currentHeartRate = 0.0;
  double currentTime = 0.0;

  List<double> gyroX = <double>[];
  List<double> gyroY = <double>[];
  List<double> gyroZ = <double>[];
  List<FlSpot> spotX = <FlSpot>[];
  List<FlSpot> spotY = <FlSpot>[];
  List<FlSpot> spotZ = <FlSpot>[];

  @override
  void initState() {
    super.initState();

    stopwatch = Stopwatch();
    stopwatch.start();

    channel = IOWebSocketChannel.connect('ws://192.168.0.47:8080');
    channel.stream.listen((data) {
      setState(() {
        Map<String, dynamic> decodedData = jsonDecode(data);
        currentAccelX = decodedData['accelX'].last.toDouble();
        currentAccelY = decodedData['accelY'].last.toDouble();
        currentAccelZ = decodedData['accelZ'].last.toDouble();
        currentGyroX = decodedData['gyroX'].last.toDouble();
        currentAccelY = decodedData['gyroY'].last.toDouble();
        currentAccelZ = decodedData['gyroZ'].last.toDouble();
        currentHeartRate = decodedData['heartRate'].last.toDouble().round().toDouble();

        currentTime = (stopwatch.elapsedMilliseconds).toDouble();
        gyroX.add(currentGyroX);
        gyroY.add(currentGyroY);
        gyroZ.add(currentGyroZ);

        spotX.add(FlSpot(currentTime, currentGyroX));
        spotY.add(FlSpot(currentTime, currentGyroY));
        spotZ.add(FlSpot(currentTime, currentGyroZ));

        List<double> maximums = <double>[gyroX.reduce(max), gyroY.reduce(max), gyroZ.reduce(max)];
        List<double> minimums = <double>[gyroX.reduce(min), gyroY.reduce(min), gyroZ.reduce(min)];
        largest = maximums.reduce(max);
        smallest = minimums.reduce(min);

        if (startTime == null && timer == null) {
          startTime = DateTime.now();
          timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
            updateDuration();
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

  Widget buildGraph(){
    if(timer == null){
      return Center(
        child: Text('No data available',
            style: GoogleFonts.lato(fontSize: 24)),
      );
    }

    return AspectRatio(
      aspectRatio: 2.0,
      child: LineChart(
        LineChartData(
          minX: 0.0,
          maxX: currentTime,
          minY: smallest,
          maxY: largest,
          lineBarsData: [
            LineChartBarData(
              spots: spotX,
              color: Colors.red,
              barWidth: 1.0,
              isCurved: true,
              isStrokeCapRound: true,
            ),
            LineChartBarData(
              spots: spotY,
              color: Colors.blue,
              barWidth: 1.0,
              isCurved: true,
              isStrokeCapRound: true,
            ),
            LineChartBarData(
              spots: spotZ,
              color: Colors.green,
              barWidth: 1.0,
              isCurved: true,
              isStrokeCapRound: true,
            ),
          ],
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Range of Motion Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: buildGraph()),
            const SizedBox(height: 20),
            Text(
              'Heart Rate: ${currentHeartRate.round()} BPM',
              style: GoogleFonts.lato(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Text(
              'Duration: ${durationInSeconds.toStringAsFixed(0)} seconds',
              style: GoogleFonts.lato(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Button(
              onTap: () {
                if(stopwatch.isRunning){
                  stopwatch.stop();
                }
                if (timer != null && timer!.isActive) {
                  timer!.cancel();
                  timer = null;
                }
                },
              text: "Save and See Results",
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}