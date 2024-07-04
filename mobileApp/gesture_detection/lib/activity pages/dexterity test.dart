import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class DexterityTestPage extends StatefulWidget {
  const DexterityTestPage({super.key});

  @override
  _DexterityTestPageState createState() => _DexterityTestPageState();
}

class _DexterityTestPageState extends State<DexterityTestPage> {
  late WebSocketChannel channel;
  Offset currentOffset = Offset.zero;
  List<Offset> points = [];
  double scaleFactor = 2.0; // Scale factor to make movement slower

  @override
  void initState() {
    super.initState();
    channel = IOWebSocketChannel.connect('ws://192.168.0.13:8081');
    channel.stream.listen((data) {
      setState(() {
        Map<String, dynamic> decodedData = jsonDecode(data);

        if (decodedData.containsKey('accelX') && decodedData['accelX'].isNotEmpty) {
          double accelX = decodedData['accelX'].last;
          double accelY = decodedData['accelY'].last;

          // Scale down the movement to make it slower
          currentOffset = Offset(currentOffset.dx + accelX / scaleFactor, currentOffset.dy + accelY / scaleFactor);
          points.add(currentOffset);
        }
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
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            points.add(details.localPosition);
          });
        },
        onPanEnd: (details) {
          points.add(Offset.zero);
        },
        child: CustomPaint(
          painter: DrawPainter(points),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class DrawPainter extends CustomPainter {
  final List<Offset> points;

  DrawPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != Offset.zero && points[i + 1] != Offset.zero) {
        canvas.drawLine(points[i], points[i + 1], paint);
      } else if (points[i] != Offset.zero && points[i + 1] == Offset.zero) {
        canvas.drawPoints(PointMode.points, [points[i]], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
