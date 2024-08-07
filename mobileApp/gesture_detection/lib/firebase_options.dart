// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAXjoNRMC67ZC4HeIkaMaJRp9UQQdoGdj8',
    appId: '1:916195498564:web:51cd0df8939bd2f4a7ba11',
    messagingSenderId: '916195498564',
    projectId: 'gesturerecognitionapplication',
    authDomain: 'gesturerecognitionapplication.firebaseapp.com',
    storageBucket: 'gesturerecognitionapplication.appspot.com',
    measurementId: 'G-12P6YTK22Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDk3aubadch99BzVsIkq8Ij8z69yhWMwho',
    appId: '1:916195498564:android:21d73011f84d3c1aa7ba11',
    messagingSenderId: '916195498564',
    projectId: 'gesturerecognitionapplication',
    storageBucket: 'gesturerecognitionapplication.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB4qaJgFpQbqYnyVOhKHQ357zA0-EOHNdk',
    appId: '1:916195498564:ios:22f4bf796f95e35ea7ba11',
    messagingSenderId: '916195498564',
    projectId: 'gesturerecognitionapplication',
    storageBucket: 'gesturerecognitionapplication.appspot.com',
    iosBundleId: 'com.example.gestureDetection',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB4qaJgFpQbqYnyVOhKHQ357zA0-EOHNdk',
    appId: '1:916195498564:ios:22f4bf796f95e35ea7ba11',
    messagingSenderId: '916195498564',
    projectId: 'gesturerecognitionapplication',
    storageBucket: 'gesturerecognitionapplication.appspot.com',
    iosBundleId: 'com.example.gestureDetection',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAXjoNRMC67ZC4HeIkaMaJRp9UQQdoGdj8',
    appId: '1:916195498564:web:a2b97ff36dd1533aa7ba11',
    messagingSenderId: '916195498564',
    projectId: 'gesturerecognitionapplication',
    authDomain: 'gesturerecognitionapplication.firebaseapp.com',
    storageBucket: 'gesturerecognitionapplication.appspot.com',
    measurementId: 'G-BH8J2N7PB6',
  );
}
