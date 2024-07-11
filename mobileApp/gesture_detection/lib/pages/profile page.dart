import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/components/ProfileDropDown.dart';
import 'package:gesture_detection/components/ProfileTextField.dart';
import '../services/user provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? selectedGender;
  String? selectedFeet;
  String? selectedInches;
  String? selectedImpairment;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.fetchUserData().then((_) {
      if (userProvider.user != null) {
        final user = userProvider.user!;
        nameController.text = user.name ?? '';
        ageController.text = user.age ?? '';
        weightController.text = user.weight ?? '';
        selectedGender = user.gender;
        selectedFeet = user.feet;
        selectedInches = user.inches;
        selectedImpairment = user.impairment;
      } else {
        // Clear fields if user data does not exist
        nameController.clear();
        ageController.clear();
        weightController.clear();
        selectedGender = null;
        selectedFeet = null;
        selectedInches = null;
        selectedImpairment = null;
      }
      setState(() {});
    });
  }


  Future<void> saveProfile() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final name = nameController.text;
      final age = ageController.text;
      final weight = weightController.text;

      await userProvider.saveUserData({
        'name': name,
        'age': age,
        'weight': weight,
        'ft': selectedFeet,
        'in': selectedInches,
        'gender': selectedGender,
        'impairment': selectedImpairment,
        'email': FirebaseAuth.instance.currentUser!.email,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Profile Setup'),
      ),
      body: 
          ListView(
              children: [
                const SizedBox(height: 5),
                const Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 100.0,
                ),
                Text(
                  user?.email ?? '',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Text(
                    "My Details",
                    style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ProfileTextField(
                  text: "Name",
                  hintText: "Enter your full name",
                  keyboardType: TextInputType.name,
                  controller: nameController,
                ),
                const SizedBox(height: 10),
                ProfileTextField(
                  text: "Age",
                  hintText: "Enter your age",
                  keyboardType: TextInputType.number,
                  controller: ageController,
                ),
                const SizedBox(height: 10),
                ProfileTextField(
                  text: "Weight",
                  hintText: "Enter your weight",
                  keyboardType: TextInputType.number,
                  controller: weightController,
                ),
                const SizedBox(height: 10),
                ProfileDropDown(
                  initialGender: selectedGender,
                  initialImpairment: selectedImpairment,
                  initialFeet: selectedFeet,
                  initialInches: selectedInches,
                  onGenderChanged: (String? newGender) {
                    setState(() {
                      selectedGender = newGender;
                    });
                  },
                  onFeetChanged: (String? newHeight) {
                    setState(() {
                      selectedFeet = newHeight;
                    });
                  },
                  onInchesChanged: (String? newInches) {
                    setState(() {
                      selectedInches = newInches;
                    });
                  },
                  onImpairmentChanged: (String? newImpairment) {
                    setState(() {
                      selectedImpairment = newImpairment;
                    });
                  },
                ),
                const SizedBox(height: 40),
                Button(
                  onTap: saveProfile,
                  text: "Save Changes",
                ),
              ],
            ),
    );
  }
}
