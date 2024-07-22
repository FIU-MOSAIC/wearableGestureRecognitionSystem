import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages/auth page.dart';
import 'services/user provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensure all bindings are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // initialize firebase with default options
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()), // provide userprovider to the widget tree
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
        cardColor: Colors.black, // global cursor color for all input fields
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.black, // specifically setting the selection handle color
          cursorColor: Colors.black, // specifically setting the cursor color
        ),
      ),
      debugShowCheckedModeBanner: false, // disable the debug banner
      home: const AuthPage(), // set the initial route to authpage
    );
  }
}
