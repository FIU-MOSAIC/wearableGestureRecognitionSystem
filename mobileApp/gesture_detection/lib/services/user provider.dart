import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gesture_detection/services/user%20model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  DateTime? lastBalanceStabilityDate;

  UserModel? get user => _user;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchUserData() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          _user = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        } else {
          _user = null; // Set to null if user does not exist
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> saveUserData(Map<String, dynamic> data) async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception("User not logged in");
      }
      await _firestore.collection('users').doc(currentUser.uid).set(data);
      _user = UserModel.fromMap(data);
      notifyListeners();
    } catch (e) {
      print("Error saving user data: $e");
      throw e;
    }
  }
  Future<void> fetchLastActivityDate() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        var result = await _firestore.collection('users')
                    .doc(currentUser.uid)
                    .collection('balance_stability_results')
                    .orderBy('testDate', descending: true)
                    .limit(1)
                    .get();

        if (result.docs.isNotEmpty) {
          lastBalanceStabilityDate = result.docs.first.data()['testDate'].toDate();
        } else {
          lastBalanceStabilityDate = null;
        }
        notifyListeners();
      }
    } catch (e) {
      print("Error fetching last activity date: $e");
    }
  }
}

