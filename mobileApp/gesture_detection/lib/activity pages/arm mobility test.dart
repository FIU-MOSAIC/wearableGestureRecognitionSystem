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
import '../results pages/arm mobility result page.dart';

class ArmMobilityTestPage extends StatefulWidget {
  final int timerDuration;
  const ArmMobilityTestPage({super.key, required this.timerDuration});

  @override
  _ArmMobilityTestPageState createState() => _ArmMobilityTestPageState();
}

class _ArmMobilityTestPageState extends State<ArmMobilityTestPage> {
  late WebSocketChannel channel;
  Timer? timer;
  Timer? autoSaveTimer;
  DateTime? startTime;
  double durationInSeconds = 0;
  List<FlSpot> dataPointsI = [];
  List<FlSpot> dataPointsJ = [];
  List<FlSpot> dataPointsK = [];
  bool _isSaving = false;

  double orientationI = 0.0, orientationJ = 0.0, orientationK = 0.0;
  double heartRate = 0.0;

  @override
  void initState() {
    super.initState();

    // establish websocket connection
    channel = IOWebSocketChannel.connect('ws://192.168.0.47:8080'); //modify with your IP address
    // listen for data from websocket
    channel.stream.listen((data) {
      setState(() {
        processOrientationData(data);
        processHeartRateData(data);
      });
    });
  }

  void processOrientationData(String data) {
    // decode data received from websocket
    Map<String, dynamic> decodedData = jsonDecode(data);
    
    // check and update orientation data
    if (decodedData.containsKey('orientationI') && decodedData['orientationI'] != null && decodedData['orientationI'].isNotEmpty) {
      orientationI = (decodedData['orientationI'].last as num).toDouble();
    }
    if (decodedData.containsKey('orientationJ') && decodedData['orientationJ'] != null && decodedData['orientationJ'].isNotEmpty) {
      orientationJ = (decodedData['orientationJ'].last as num).toDouble();
    }
    if (decodedData.containsKey('orientationK') && decodedData['orientationK'] != null && decodedData['orientationK'].isNotEmpty) {
      orientationK = (decodedData['orientationK'].last as num).toDouble();
    }

    // start timer if it hasn't been started
    if (startTime == null && timer == null) {
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
    if (decodedData.containsKey('heartRate') && decodedData['heartRate'] != null && decodedData['heartRate'].isNotEmpty) {
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
      dataPointsI.add(FlSpot(durationInSeconds, orientationI));
      dataPointsJ.add(FlSpot(durationInSeconds, orientationJ));
      dataPointsK.add(FlSpot(durationInSeconds, orientationK));
    });
  }

  @override
  void dispose() {
    // clean up resources
    timer?.cancel();
    autoSaveTimer?.cancel();
    dataPointsI.clear();
    dataPointsJ.clear();
    dataPointsK.clear();
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
      FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Arm_Mobility_Results').add({
        'dataPointsI': dataPointsI.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'dataPointsJ': dataPointsJ.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'dataPointsK': dataPointsK.map((point) => {'x': point.x, 'y': point.y}).toList(),
        'duration': durationInSeconds,
        'heartRate': heartRate,
        'testDate': DateTime.now(),
      }).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ArmMobilityResultPage()));
      }).catchError((error) {
        print("Failed to add result: $error");
      }).whenComplete(() {
        setState(() {
          _isSaving = false;
          dataPointsI.clear();
          dataPointsJ.clear();
          dataPointsK.clear();
        });
      });
    } else {
      print('No user logged in');
    }
  }

  Widget buildGraph() {
    if (dataPointsI.isEmpty && dataPointsJ.isEmpty && dataPointsK.isEmpty) {
      return Center(
        child: Text(
          'No data available',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: LineChart(
        LineChartData(
          minX: 0,
          maxX: durationInSeconds,
          minY: -1,
          maxY: 1,
          lineBarsData: [
            LineChartBarData(
              spots: dataPointsI,
              isCurved: true,
              color: Colors.red,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: dataPointsJ,
              isCurved: true,
              color: Colors.green,
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
            LineChartBarData(
              spots: dataPointsK,
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
        title: const Text('Arm Mobility Exercise'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: buildGraph()),
            const SizedBox(height: 20),
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
