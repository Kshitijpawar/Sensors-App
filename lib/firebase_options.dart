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
    apiKey: 'AIzaSyB_Wj2j0oEChEN9CnKX6Pi47MQWhleIpCs',
    appId: '1:917185126462:web:92ade96a630bf7d107f16f',
    messagingSenderId: '917185126462',
    projectId: 'flutter-prep-bda5b',
    authDomain: 'flutter-prep-bda5b.firebaseapp.com',
    databaseURL: 'https://flutter-prep-bda5b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-bda5b.appspot.com',
    measurementId: 'G-9E4DX5N2R5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQoBCx24PqB9cV1RSEuV37ZhiojJX2-0w',
    appId: '1:917185126462:android:d6b871358d45073007f16f',
    messagingSenderId: '917185126462',
    projectId: 'flutter-prep-bda5b',
    databaseURL: 'https://flutter-prep-bda5b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-bda5b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAcDnpKbLMWsBoUOgQDznO1BYwMuwvQmRM',
    appId: '1:917185126462:ios:0aceb96ea7eb233307f16f',
    messagingSenderId: '917185126462',
    projectId: 'flutter-prep-bda5b',
    databaseURL: 'https://flutter-prep-bda5b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-bda5b.appspot.com',
    iosBundleId: 'com.example.sensorsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAcDnpKbLMWsBoUOgQDznO1BYwMuwvQmRM',
    appId: '1:917185126462:ios:0aceb96ea7eb233307f16f',
    messagingSenderId: '917185126462',
    projectId: 'flutter-prep-bda5b',
    databaseURL: 'https://flutter-prep-bda5b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-bda5b.appspot.com',
    iosBundleId: 'com.example.sensorsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB_Wj2j0oEChEN9CnKX6Pi47MQWhleIpCs',
    appId: '1:917185126462:web:26bafcde7352205407f16f',
    messagingSenderId: '917185126462',
    projectId: 'flutter-prep-bda5b',
    authDomain: 'flutter-prep-bda5b.firebaseapp.com',
    databaseURL: 'https://flutter-prep-bda5b-default-rtdb.firebaseio.com',
    storageBucket: 'flutter-prep-bda5b.appspot.com',
    measurementId: 'G-03ESSKVGET',
  );
}