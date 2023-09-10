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
    apiKey: 'AIzaSyDE-r7TYaUFb9eot53aj2lX91p62wpC1us',
    appId: '1:315847861355:web:d9a8b462799d95bf963d2e',
    messagingSenderId: '315847861355',
    projectId: 'dictionary-app-953bf',
    authDomain: 'dictionary-app-953bf.firebaseapp.com',
    databaseURL: 'https://dictionary-app-953bf-default-rtdb.firebaseio.com',
    storageBucket: 'dictionary-app-953bf.appspot.com',
    measurementId: 'G-JD74RV8CQD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAK-MLdP99gl8JfrXvZDfP_URDSAc65QQw',
    appId: '1:315847861355:android:8d7c5619e1bd726f963d2e',
    messagingSenderId: '315847861355',
    projectId: 'dictionary-app-953bf',
    databaseURL: 'https://dictionary-app-953bf-default-rtdb.firebaseio.com',
    storageBucket: 'dictionary-app-953bf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAnT3p6DhLSHHchMOLflNBEw4nF6Z056Kc',
    appId: '1:315847861355:ios:fa9199dfa636c4aa963d2e',
    messagingSenderId: '315847861355',
    projectId: 'dictionary-app-953bf',
    databaseURL: 'https://dictionary-app-953bf-default-rtdb.firebaseio.com',
    storageBucket: 'dictionary-app-953bf.appspot.com',
    iosClientId: '315847861355-a4aile33untqmi1b5pg3tbsa7qotnrtv.apps.googleusercontent.com',
    iosBundleId: 'com.example.dictionaryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAnT3p6DhLSHHchMOLflNBEw4nF6Z056Kc',
    appId: '1:315847861355:ios:6d14139c51a90c3a963d2e',
    messagingSenderId: '315847861355',
    projectId: 'dictionary-app-953bf',
    databaseURL: 'https://dictionary-app-953bf-default-rtdb.firebaseio.com',
    storageBucket: 'dictionary-app-953bf.appspot.com',
    iosClientId: '315847861355-cven6clp55m75cu5bk2kgn33jbfuungf.apps.googleusercontent.com',
    iosBundleId: 'com.example.dictionaryApp.RunnerTests',
  );
}