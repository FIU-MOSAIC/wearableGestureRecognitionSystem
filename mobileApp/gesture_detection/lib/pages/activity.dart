import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';// dont think i should be passing the user into the page will ask orlando later
import 'package:gesture_detection/components/Button.dart';// button importer isnt working with the page itself

class ActivityPage extends StatefulWidget{
  const ActivityPage({super.key});
  @override
  State<ActivityPage> createState() => _ActivityPage();
}

class _ActivityPage extends State<ActivityPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}