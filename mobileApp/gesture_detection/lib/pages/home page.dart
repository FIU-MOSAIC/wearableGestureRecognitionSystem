import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/ActivityTile.dart';
import 'package:gesture_detection/components/Drawer.dart';
import 'package:gesture_detection/pages/activity%20instruction%20page.dart';
import 'package:gesture_detection/pages/profile%20page.dart';
import 'package:gesture_detection/services/user%20provider.dart';
import 'package:provider/provider.dart';

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
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        signOut: signUserOut,
        onProfileTap: goToProfilePage,
      ),
      body: user == null
          ? Center(child: const CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Welcome ${user.name ?? ''}',
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Recent Activities:",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Dexterity Test: Last performed on [Date]", style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),),
                      Text("Range of Motion:Last performed on [Date]", style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),),
                      Text("Reflex Test: Last performed on [Date]", style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600],
                      ),),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Activities:",
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                ActivityTile(title: 'Dexterity Test', imagePath: 'lib/images/Dexterity Test Icon.png', width: 225, onTap:
                 () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityInstructionPage(title: 'Dexterity Test')));
                  },),

                ActivityTile(title: 'Range of Motion Test', imagePath: 'lib/images/Range of Motion Icon.png', width: 297, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityInstructionPage(title: 'Range of Motion Test')));
                  },),
                ActivityTile(title: 'Reflex Test', imagePath: 'lib/images/Reflex Test Icon.png', width: 195, onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> ActivityInstructionPage(title: 'Reflex Test')));
                  },),
              ],
            ),
    );
  }
}
