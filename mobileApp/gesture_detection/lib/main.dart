import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/auth page.dart';
import 'services/user provider.dart';


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
      child: const MyApp(),
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
    selectionHandleColor: Colors.black,
    cursorColor: Colors.black, // specifically setting the cursor color
    ),

  ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}