import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  Widget buildTeamMember(String name, String role, String imagePath) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: GoogleFonts.lato(
            fontSize: 18.0,
            color: Colors.grey[900],
          ),
        ),
        subtitle: Text(
          role,
          style: GoogleFonts.lato(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget buildProductOwner(String name, String role, String imagePath) {
    return Card(
      color: Colors.blue[50],
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(imagePath),
        ),
        title: Text(
          name,
          style: GoogleFonts.lato(
            fontSize: 18.0,
            color: Colors.blue[900],
          ),
        ),
        subtitle: Text(
          role,
          style: GoogleFonts.lato(
            fontSize: 16.0,
            color: Colors.blue[600],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[900],
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              child: Center(
                child: Image.asset(
                  'lib/images/mosaic-logo.png',
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'In this project, students will develop a mobile/wearable app/service (for iOS, Android, and Fitbit devices) that provides hand motion instructions (either on the wearable or the phone) to a Fitbit user, which are then captured by the motion sensors of the wearable and sent back to the phone (and from there into a cloud service). '
                      'The purpose is to measure things such as hand dexterity, range of motion, reflexes, hand-eye coordination, etc., for individuals with motor impairments (e.g., due to a stroke). '
                      'In addition, a camera setup will be used to provide a reference for the hand/finger motions. Time permitting, the developed system will visualize the hand/fingers on the screen of the phone app or in a browser. '
                      'Students will work with smartphone development tools (most likely Google\'s Flutter development platform), the Fitbit API and SDK, and various server/web tools.',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product Owner',
                    style: GoogleFonts.lato(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildProductOwner('Christian Poellabauer', 'Product Owner', 'lib/images/Poeallabauer.png'),
                  const SizedBox(height: 20),
                  Text(
                    'Meet the Team',
                    style: GoogleFonts.lato(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildTeamMember('Orlando Gonzalez', 'Full Stack', 'lib/images/orlando_gonzalez.png'),
                  const SizedBox(height: 10),
                  buildTeamMember('Juan Salas Paredes', 'Front-End', 'lib/images/juanSalasParedes.jpg'),
                  const SizedBox(height: 10),
                  buildTeamMember('Piercen Rychlik', 'Back-End', 'lib/images/orlando_gonzalez.png'),
                  const SizedBox(height: 10),
                  buildTeamMember('Roberto Di Bari', 'Back-End', 'lib/images/robertodibari.jpg'),
                  const SizedBox(height: 10),
                  buildTeamMember('Percy Gomez Torres', 'Front-End', 'lib/images/orlando_gonzalez.png'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
