// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCgH4w2v0vZC6gSc6Cgn3elW4OAxBPf2JE',
    appId: '1:513466562597:web:e7f821ec53c6607818a7cc',
    messagingSenderId: '513466562597',
    projectId: 'payflow-75bf8',
    authDomain: 'payflow-75bf8.firebaseapp.com',
    storageBucket: 'payflow-75bf8.appspot.com',
    measurementId: 'G-L4Q7JP7R0F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBKPyQjkzgr-q6ofHNFqwOsRv8gB77RWzM',
    appId: '1:513466562597:android:13e374ac95406fe818a7cc',
    messagingSenderId: '513466562597',
    projectId: 'payflow-75bf8',
    storageBucket: 'payflow-75bf8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7VA2HejWbJTBgmBj0erDiOuy-rqdL-lo',
    appId: '1:513466562597:ios:3605a85ad34743c118a7cc',
    messagingSenderId: '513466562597',
    projectId: 'payflow-75bf8',
    storageBucket: 'payflow-75bf8.appspot.com',
    iosBundleId: 'com.example.payFlow',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD7VA2HejWbJTBgmBj0erDiOuy-rqdL-lo',
    appId: '1:513466562597:ios:fc84663000c3d85b18a7cc',
    messagingSenderId: '513466562597',
    projectId: 'payflow-75bf8',
    storageBucket: 'payflow-75bf8.appspot.com',
    iosBundleId: 'com.example.payFlow.RunnerTests',
  );
}
