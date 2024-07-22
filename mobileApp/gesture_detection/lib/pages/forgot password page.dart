// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/components/FormTextField.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password reset email sent')));
    } on FirebaseAuthException {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[100], // app bar background color
        title: const Text('Forgot Password?'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // center the content vertically
          children: [
           Text(
              'Enter your email to reset your password.',
              style: GoogleFonts.lato(fontSize: 18),
            ),
            const SizedBox(height: 20), // space between text and text field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20), // horizontal padding for text field
              child: FormTextField(
                hintText: 'Email',
                obscureText: false,
                controller: emailController,
              ),
            ),
            const SizedBox(height: 20), // space between text field and button
            Padding(
              padding: const EdgeInsets.all(18.0), // padding around the button
              child: Button(onTap: resetPassword, text: "Reset Password"),
            )
          ],
        ),
      ),
    );
  }
}
