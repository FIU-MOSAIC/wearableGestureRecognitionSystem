import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'results model.dart';
import 'user model.dart';

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
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();
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

  Future<List<ExerciseResult>> fetchAllResults() async {
    List<ExerciseResult> results = [];
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      List<String> exerciseCollections = [
        'Balance_and_Stability_Results'
      ]; // add more collections here
      for (var collection in exerciseCollections) {
        var querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection(collection)
            .orderBy('testDate', descending: true)
            .get();
        results.addAll(querySnapshot.docs
            .map((doc) => ExerciseResult.fromMap(doc.data(),
                collection.replaceAll('_Results', '').replaceAll('_', ' ')))
            .toList());
      }
    }
    return results;
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
      rethrow;
    }
  }

  Future<void> fetchLastActivityDate() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        var result = await _firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('Balance_and_Stability_Results')
            .orderBy('testDate', descending: true)
            .limit(1)
            .get();

        if (result.docs.isNotEmpty) {
          lastBalanceStabilityDate =
              result.docs.first.data()['testDate'].toDate();
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
