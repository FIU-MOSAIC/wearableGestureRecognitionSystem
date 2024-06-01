import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/components/FormTextField.dart';
import 'package:gesture_detection/components/SquareTile.dart';
import 'package:gesture_detection/services/auth%20service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  //sign user up method
  void signUserUp() async {
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
    });

    //check if passwords match
    if (passwordController.text != confirmedPasswordController.text) {
      setState(() {
        confirmPasswordError = "Passwords don't match";
      });
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setState(() {
          emailError = 'Email already in use. Please recover your password.';
        });
      } else if (e.code == 'invalid-email') {
        setState(() {
          emailError = 'Invalid email';
        });
      } else if (e.code == 'weak-password') {
        setState(() {
          passwordError = 'Weak password';
        });
      } else {
        setState(() {
          emailError = 'An error occurred: ${e.message}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.account_circle, size: 100),
                const SizedBox(height: 20),
                const Text(
                  "Let's create an account.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    if (emailError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          emailError!,
                          style: TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    if (passwordError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          passwordError!,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormTextField(
                      controller: confirmedPasswordController,
                      hintText: 'Confirm Password',
                      obscureText: true,
                    ),
                    if (confirmPasswordError != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            confirmPasswordError!,
                            style: const TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Button(
                  text: 'Sign up',
                  onTap: signUserUp,
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png'),
                    const SizedBox(width: 60),
                    SquareTile(
                      onTap: () => (){},
                      imagePath: 'lib/images/apple.png'),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Login now.',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
