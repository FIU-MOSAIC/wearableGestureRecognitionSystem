import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../activity pages/arm mobility test.dart';

class ArmMobilityInstructionPage extends StatefulWidget {
  final String title;
  const ArmMobilityInstructionPage({Key? key, required this.title}) : super(key: key);

  @override
  State<ArmMobilityInstructionPage> createState() => _ArmMobilityInstructionPageState();
}

class _ArmMobilityInstructionPageState extends State<ArmMobilityInstructionPage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
              'Move your arm up and down.\n'
              'Swing your arm left and right.\n'
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
                RadioListTile<int>(
                  activeColor: Colors.grey,
                  title: Text("Manual Save", style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                  )),
                  value: -1,
                  groupValue: selectedTimer,
                  onChanged: (value) {
                    setState(() {
                      selectedTimer = value;
                      customTimerController.clear();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 5),
            Button(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArmMobilityTestPage(timerDuration: selectedTimer ?? 0),
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
