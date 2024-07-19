import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/ActivityTile.dart';
import 'package:gesture_detection/components/Drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Instruction pages/balance stability instructions.dart';
import '../Instruction pages/arm rotation instruction page.dart';
import '../Instruction pages/arm mobility instruction page.dart';
import '../services/user provider.dart';
import 'about us page.dart';
import 'history page.dart';
import 'login page.dart';
import 'profile page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUserData();
    Provider.of<UserProvider>(context, listen: false).fetchLastActivityDate();
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut().then((_) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage(onTap: () {},)),
        (Route<dynamic> route) => false,
      );
    });
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
  }

  void goToHistoryPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryPage(),
      ),
    );
  }

  void goToAboutUsPage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AboutUsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        signOut: signUserOut,
        onProfileTap: goToProfilePage,
        onHistoryTap: goToHistoryPage,
        onAboutUsTap: goToAboutUsPage,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Welcome ${user?.name ?? ''}',
                  style: GoogleFonts.lato(
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Recent Activities",
                style: GoogleFonts.lato(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Last Performed:",
                style: GoogleFonts.lato(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance and Stability: ${userProvider.lastBalanceStabilityDate != null ? DateFormat('MMM dd, yyyy - h:mm a').format(userProvider.lastBalanceStabilityDate!) : 'No data available'}",
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    "Arm Rotation: ${userProvider.lastArmRotationTestDate != null ? DateFormat('MMM dd, yyyy - h:mm a').format(userProvider.lastArmRotationTestDate!) : 'No data available'}",
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.grey[800],
                    ),
                  ),
                  Text(
                    "Arm Mobility: ${userProvider.lastArmMobilityTestDate != null ? DateFormat('MMM dd, yyyy - h:mm a').format(userProvider.lastArmMobilityTestDate!) : 'No data available'}",
                    style: GoogleFonts.lato(
                      fontSize: 15.0,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Divider(color: Colors.grey[400]),
              const SizedBox(height: 15),
              Text(
                "Activities",
                style: GoogleFonts.lato(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 15.0),
              ActivityTile(
                title: 'Balance and Stability',
                imagePath: 'lib/images/balance and stability.png',
                width: 280,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const BalanceStabilityInstruction(title: 'Balance and Stability')));
                },
              ),
              ActivityTile(
                title: 'Arm Rotation',
                imagePath: 'lib/images/arm rotation.png',
                width: 280,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ArmRotationInstructionPage(title: 'Arm Rotation')));
                },
              ),
              ActivityTile(
                title: 'Arm Mobility',
                imagePath: 'lib/images/arm mobility.png',
                width: 280,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const ArmMobilityInstructionPage(title: 'Arm Mobility')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
