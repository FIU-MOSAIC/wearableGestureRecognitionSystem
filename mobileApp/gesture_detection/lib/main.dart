import 'package:flutter/material.dart';
import 'package:gesture_detection/pages/auth%20page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gesture_detection/services/user%20provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
   runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // application root  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
    cardColor: Colors.black,  // global cursor color for all input fields
    textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black, // specifically setting the cursor color
    ),

  ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}