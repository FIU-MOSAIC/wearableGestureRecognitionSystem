import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // Google Sign In
  signInWithGoogle() async {
    //sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    //obtain details form request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    //create new credentials for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    //sing in
    return FirebaseAuth.instance.signInWithCredential(credential); 
  }
}