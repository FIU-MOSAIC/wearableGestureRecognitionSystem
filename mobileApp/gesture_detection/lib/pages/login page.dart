import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gesture_detection/components/Button.dart';
import 'package:gesture_detection/components/FormTextField.dart';
import 'package:gesture_detection/components/SquareTile.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth service.dart';
import 'forgot password page.dart';
import 'home page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  // sign user in method
void signUserIn() async {
  setState(() {
    emailError = null;
    passwordError = null;
  });
  
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    // Navigate to the HomePage after successful login
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const HomePage()), // Replace `HomePage` with your home page widget
      (Route<dynamic> route) => false,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'invalid-email') {
      setState(() {
        emailError = 'Invalid email';
      });
    } else if (e.code == 'wrong-password') {
      setState(() {
        passwordError = 'Invalid password';
      });
    } else {
      setState(() {
        emailError = 'Invalid email or password';
      });
    }
  }
}
 void signInWithGoogle() async {
    UserCredential? userCredential = await AuthService().signInWithGoogle();
    if (userCredential != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomePage()), // Replace `HomePage` with your home page widget
        (Route<dynamic> route) => false,
      );
    } else {
      // Handle sign in error
      setState(() {
        emailError = 'Google sign in failed';
      });
    }
  }
  //login page content
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const Icon(Icons.account_circle, size: 100),
                const SizedBox(height: 20),
                Text(
                  "Welcome back, you've been missed.",
                  style: GoogleFonts.lato(fontSize: 16),
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
                          style: GoogleFonts.lato(color: Colors.red, fontSize: 14),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
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
                          style: GoogleFonts.lato(color: Colors.red, fontSize: 14),
                        ),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return const ForgotPasswordPage();
                          },),);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Forgot password?',
                           style: GoogleFonts.lato(color: Colors.grey[800], fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Button(
                  text: 'Sign In',
                  onTap: signUserIn,
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
                          style: GoogleFonts.lato(color: Colors.grey[800]),
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
                      onTap: signInWithGoogle,
                      imagePath: 'lib/images/google.png',
                       size: 90,),
                    const SizedBox(width: 60),
                    SquareTile(
                      onTap: (){},
                      imagePath: 'lib/images/apple.png',
                      size: 90,),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not a member?', style: GoogleFonts.lato(fontSize: 16)),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now.',
                        style: GoogleFonts.lato(
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