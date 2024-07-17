import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:gesture_detection/Instruction%20pages/dexterity%20instruction%20page.dart';
import 'package:gesture_detection/Instruction%20pages/range%20of%20motion%20instruction%20page.dart';
import 'package:gesture_detection/Instruction%20pages/reflex%20instruction%20page.dart';
=======
>>>>>>> main
import 'package:gesture_detection/components/ActivityTile.dart';
import 'package:gesture_detection/components/Drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Instruction pages/balance stability instructions.dart';
import '../Instruction pages/range of motion instruction page.dart';
import '../Instruction pages/reflex instruction page.dart';
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
      MaterialPageRoute(builder: (context) => LoginPage(onTap: () {},)), // Replace `LoginPage` with your login page widget
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
      body: user == null
          ? Center(child: const CircularProgressIndicator())
          : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Welcome ${user.name ?? ''}',
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
                      Text("Range of Motion: [Date]", style: GoogleFonts.lato(
                        fontSize: 15.0,
                        color: Colors.grey[800],
                      ),),
                      Text("Reflex Test: [Date]", style: GoogleFonts.lato(
                        fontSize: 15.0,
                        color: Colors.grey[800],
                      ),),
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
<<<<<<< HEAD
                  ActivityTile(title: 'Dexterity Test', imagePath: 'lib/images/Dexterity Test Icon.png', width: 225, onTap:
=======
                  ActivityTile(title: 'Balance and Stability', imagePath: 'lib/images/balance and stability.png', width: 280, onTap:
>>>>>>> main
                   () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DexterityInstructionPage(title: 'Dexterity Test')));
                    },),
            
<<<<<<< HEAD
                  ActivityTile(title: 'Range of Motion Test', imagePath: 'lib/images/Range of Motion Icon.png', width: 297, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> RangeOfMotionInstructionPage(title: 'Range of Motion Test')));
                    },),
                  ActivityTile(title: 'Reflex Test', imagePath: 'lib/images/Reflex Test Icon.png', width: 195, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ReflexIntructionPage(title: 'Reflex Test')));
=======
                  ActivityTile(title: 'Range of Motion Test', imagePath: 'lib/images/Range of Motion Icon.png', width: 280, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const RangeOfMotionInstructionPage(title: 'Range of Motion Test')));
                    },),
                  ActivityTile(title: 'Reflex Test', imagePath: 'lib/images/Reflex Test Icon.png', width: 280, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ReflexIntructionPage(title: 'Reflex Test')));
>>>>>>> main
                    },),
                ],
              ),
          ),
    );
  }
}
