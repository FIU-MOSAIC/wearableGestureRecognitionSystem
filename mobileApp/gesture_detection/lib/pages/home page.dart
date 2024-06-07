import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Drawer.dart';
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
        title: const Text('Home Page'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      drawer: MyDrawer(
        signOut: signUserOut,
        onProfileTap: goToProfilePage,
      ),
      body: Center(
        child: user == null
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Welcome ${user.name ?? ''}'),
                ],
              ),
      ),
    );
  }
}
