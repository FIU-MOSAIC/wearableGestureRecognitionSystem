import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // Google Sign In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in with the credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle error
      print(e.toString());
      return null;
    }
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