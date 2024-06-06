import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/components/ProfileDropDown.dart';
import 'package:gesture_detection/components/ProfileTextField.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String? selectedGender;
  String? selectedFeet;
  String? selectedInches;
  String? selectedImpairment;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> saveProfile() async {
      try {
        final name = nameController.text;
        final age = ageController.text;
        final weight = weightController.text;

        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
          'name': name,
          'age': age,
          'weight': weight,
          'ft': selectedFeet,
          'in': selectedInches,
          'gender': selectedGender,
          'impairment': selectedImpairment,
          'email': currentUser.email,
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
    
  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

      if (userDoc.exists) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        nameController.text = data['name'] ?? '';
        ageController.text = data['age'] ?? '';
        weightController.text = data['weight'] ?? '';
        setState(() {
          selectedGender = data['gender'];
          selectedFeet = data['ft'];
          selectedInches = data['in'];
          selectedImpairment = data['impairment'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        title: const Text('Profile Setup'),
      ),
      body: isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            children: [
              const SizedBox(height: 20),
              const Icon(
                Icons.person,
                color: Colors.black,
                size: 100.0,
              ),
              Text(
                currentUser.email!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Text(
                  "My Details",
                  style: TextStyle(
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
              const SizedBox(height: 20),
              ProfileTextField(
                text: "Age",
                hintText: "Enter your age",
                keyboardType: TextInputType.number,
                controller: ageController,
              ),
              const SizedBox(height: 20),
              ProfileTextField(
                text: "Weight",
                hintText: "Enter your weight",
                keyboardType: TextInputType.number,
                controller: weightController,
              ),
              const SizedBox(height: 20),
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
                onFeetChanged: (String? newHeight){
                  setState(() {
                    selectedFeet = newHeight;
                  });
                },
                onInchesChanged: (String? newInches){
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
