import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DexterityInstructionPage extends StatefulWidget {
  final String title;
  const DexterityInstructionPage({super.key, required this.title});

  @override
  State<DexterityInstructionPage> createState() => _DexterityInstructionPageState();
}

class _DexterityInstructionPageState extends State<DexterityInstructionPage> {
  final videoURL = 'https://www.youtube.com/watch?v=T9H_yu0Me8c';

  late YoutubePlayerController _controller;

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
            const SizedBox(height: 20),
            Text(
              "Description",
              style: GoogleFonts.lato(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Step by step instructions on how to complete the activity.',
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.grey[800]),
            ),
            Text(
              'Tips for proper execution.',
              style: GoogleFonts.lato(fontSize: 16.0, color: Colors.grey[800]),
            ),
            const SizedBox(height: 20),
            Divider(color: Colors.grey[400]),
            const SizedBox(height: 20),
            Text(
              "Video",
              style: GoogleFonts.lato(
                fontSize: 23.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 40),
            Button(
                  onTap: (){},
                  text: "Start ${widget.title}",
                ),
          ],
        ),
      ),
    );
  }
}
