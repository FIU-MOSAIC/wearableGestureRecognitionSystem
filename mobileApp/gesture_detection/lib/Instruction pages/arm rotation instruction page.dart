import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../activity pages/arm rotation test.dart';

class ArmRotationInstructionPage extends StatefulWidget {
  final String title;
  const ArmRotationInstructionPage({super.key, required this.title});

  @override
  State<ArmRotationInstructionPage> createState() =>
      _ArmRotationInstructionPageState();
}

class _ArmRotationInstructionPageState extends State<ArmRotationInstructionPage> {
  final videoURL = 'https://www.youtube.com/watch?v=T9H_yu0Me8c';

  late YoutubePlayerController _controller;
  int? selectedTimer;
  TextEditingController customTimerController = TextEditingController();

  @override
  void initState() {
    final videoId = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: Text('${widget.title} Instructions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Description",
              style: GoogleFonts.lato(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Extend your arm and perform rotational movements.',
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.grey[800]),
            ),
            Text(
              'Start the activity on the phone, then in the FitBit app to record your results.',
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.grey[800]),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 5),
            Text(
              "Video",
              style: GoogleFonts.lato(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  bottomActions: [
                    CurrentPosition(),
                    ProgressBar(
                      isExpanded: true,
                      colors: const ProgressBarColors(
                        playedColor: Colors.grey,
                        handleColor: Colors.black,
                      ),
                    ),
                    RemainingDuration(),
                    FullScreenButton(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 5),
            Text(
              "Set Timer",
                style: GoogleFonts.lato(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 5),
            Column(
              children: [
                RadioListTile<int>(
                  activeColor: Colors.black,
                  title: Text("30 Seconds", style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  )),
                  value: 31,
                  groupValue: selectedTimer,
                  onChanged: (value) {
                    setState(() {
                      selectedTimer = value;
                      customTimerController.clear();
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Colors.black,
                  title: Text("1 Minute", style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  )),
                  value: 61,
                  groupValue: selectedTimer,
                  onChanged: (value) {
                    setState(() {
                      selectedTimer = value;
                      customTimerController.clear();
                    });
                  },
                ),
                Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or manual save.',
                          style: GoogleFonts.lato(color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
              ], 
            ),
            const SizedBox(height: 5),
            Button(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArmRotationTestPage(timerDuration: selectedTimer ?? 0),
                  ),
                );
              },
              text: "Start ${widget.title}",
            ),
          ],
        ),
      ),
    );
  }
}
