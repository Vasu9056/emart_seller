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
    apiKey: 'AIzaSyD1Cadv7IFbqVw-Y5UyNiUkpn0twFRRLR8',
    appId: '1:1004383296324:web:d093ae52a7a7553d2bd511',
    messagingSenderId: '1004383296324',
    projectId: 'emart-7441c',
    authDomain: 'emart-7441c.firebaseapp.com',
    storageBucket: 'emart-7441c.appspot.com',
    measurementId: 'G-3TTLJS8V6X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyClxdS2AzfDRk2sw_sgFbInhfHGyxjyECU',
    appId: '1:1004383296324:android:248da6a0172837c52bd511',
    messagingSenderId: '1004383296324',
    projectId: 'emart-7441c',
    storageBucket: 'emart-7441c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTdNSQjIvx-QN2r-YOdFzd7yxKZz4_SBk',
    appId: '1:1004383296324:ios:32a7fbc8fd36346c2bd511',
    messagingSenderId: '1004383296324',
    projectId: 'emart-7441c',
    storageBucket: 'emart-7441c.appspot.com',
    iosBundleId: 'com.example.emartSeller',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDTdNSQjIvx-QN2r-YOdFzd7yxKZz4_SBk',
    appId: '1:1004383296324:ios:d4adb5f6266d5c852bd511',
    messagingSenderId: '1004383296324',
    projectId: 'emart-7441c',
    storageBucket: 'emart-7441c.appspot.com',
    iosBundleId: 'com.example.emartSeller.RunnerTests',
  );
}