import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../results pages/balance stability result.dart';

class BalanceStabilityPage extends StatefulWidget {
  final int timerDuration;
  const BalanceStabilityPage({super.key, required this.timerDuration});

  @override
  _BalanceStabilityPageState createState() => _BalanceStabilityPageState();
}

class _BalanceStabilityPageState extends State<BalanceStabilityPage> {
  late WebSocketChannel channel;
  Timer? timer;
  Timer? autoSaveTimer;
  DateTime? startTime;
  double durationInSeconds = 0;
  List<FlSpot> dataPointsX = [];
  List<FlSpot> dataPointsY = [];
  List<FlSpot> dataPointsZ = [];
  bool _isSaving = false;

  double accelX = 0.0, accelY = 0.0, accelZ = 0.0;
  double heartRate = 0.0;

  @override
  void initState() {
    super.initState();

    // establish websocket connection
    channel = IOWebSocketChannel.connect('ws://192.168.0.47:8080'); //modify with your IP address
    // listen for data from websocket

    channel.stream.listen((data) {
      setState(() {
        processSensorData(data);
        processHeartRateData(data);
      });
    });
  }

  void processSensorData(String data) {
    // decode data received from websocket
    Map<String, dynamic> decodedData = jsonDecode(data);
    
    // check and update accelerometer data
    if (decodedData['accelX'].isNotEmpty) {
      accelX = (decodedData['accelX'].last as num).toDouble();
    }
    if (decodedData['accelY'].isNotEmpty) {
      accelY = (decodedData['accelY'].last as num).toDouble();
    }
    if (decodedData['accelZ'].isNotEmpty) {
      accelZ = (decodedData['accelZ'].last as num).toDouble();
    }

    // start timer if it hasn't been started
    if (startTime == null && timer == null && accelX != 0) {
      startTime = DateTime.now();
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        updateDuration();
        addDataPoint();
      });

      // auto-save results after a specific duration
      if (widget.timerDuration > 0) {
        autoSaveTimer = Timer(Duration(seconds: widget.timerDuration), () {
          saveResults();
        });
      }
    }
  }

  void processHeartRateData(String data) {
    // decode heart rate data
    Map<String, dynamic> decodedData = jsonDecode(data);
    if (decodedData.containsKey('heartRate') && decodedData['heartRate'].isNotEmpty) {
      heartRate = (decodedData['heartRate'].last as num).toDouble();
    }
  }

  void updateDuration() {
    if (startTime != null) {
      final now = DateTime.now();
      setState(() {
        durationInSeconds = now.difference(startTime!).inSeconds.toDouble();
      });
    }
  }

  void addDataPoint() {
    setState(() {
      dataPointsX.add(FlSpot(durationInSeconds.roundToDouble(), accelX));
      dataPointsY.add(FlSpot(durationInSeconds.roundToDouble(), accelY));
      dataPointsZ.add(FlSpot(durationInSeconds.roundToDouble(), accelZ));
    });
  }

  @override
  void dispose() {
    // clean up resources
    timer?.cancel();
    autoSaveTimer?.cancel();
    dataPointsX.clear();
    channel.sink.close();
    super.dispose();
  }

  void saveResults() async {
    setState(() {
      _isSaving = true;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // save results to Firestore
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Balance_and_Stability_Results').add({
        'dataPointsX': dataPointsX.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'dataPointsY': dataPointsY.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'dataPointsZ': dataPointsZ.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'duration': durationInSeconds,
        'testDate': DateTime.now(),
      }).then((value) {
        print("Result Added");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const BalanceStabilityResult()));
      }).catchError((error) {
        print("Failed to add result: $error");
      }).whenComplete(() {
        setState(() {
          _isSaving = false;
          dataPointsX.clear();
          dataPointsY.clear();
          dataPointsZ.clear();
        });
      });
    } else {
      print('No user logged in');
    }
  }

  Widget buildGraph() {
    if (dataPointsX.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: GoogleFonts.lato(fontWeight: FontWeight.bold),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: durationInSeconds,
          minY: -40,
          maxY: 40,
          lineBarsData: [
            LineChartBarData(
              spots: dataPointsX,
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: dataPointsY,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: dataPointsZ,
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
        ),
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
        title: const Text('Balance and Stability Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: buildGraph()),
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
            const SizedBox(height: 20),
            Text(
              'Heart Rate: ${heartRate.round()} BPM',
              style: GoogleFonts.lato(fontSize: 22),
            ),
            const SizedBox(height: 20),
            Text(
              'Duration: ${durationInSeconds.toStringAsFixed(0)} seconds',
              style: GoogleFonts.lato(fontSize: 20),
            ),
            const SizedBox(height: 15),
            if (!_isSaving)
              Button(
                onTap: () {
                  if (timer != null && timer!.isActive) {
                    timer!.cancel();
                    timer = null;
                  }
                  saveResults();
                },
                text: "Save and See Results",
              ),
            if (_isSaving) const CircularProgressIndicator(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
