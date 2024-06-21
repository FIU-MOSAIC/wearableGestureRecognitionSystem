import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

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

Future<void> fetchFitbitData(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://api.fitbit.com/1/user/-/activities/steps/date/today/1d.json'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    print('Data: ${response.body}');
  } else {
    print('Failed to fetch data');
  }
}