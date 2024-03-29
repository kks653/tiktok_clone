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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDzPWxqci13X1epSke4rKaAGi3XFkDBNWs',
    appId: '1:459258905441:web:3470e7acbca710507a3b20',
    messagingSenderId: '459258905441',
    projectId: 'tiktok-kks653',
    authDomain: 'tiktok-kks653.firebaseapp.com',
    storageBucket: 'tiktok-kks653.appspot.com',
    measurementId: 'G-067PELFYZW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDHnnDM4s9nLt9U4NHpe6Vs6Xob7ETh1Is',
    appId: '1:459258905441:android:5847b2a9587c92337a3b20',
    messagingSenderId: '459258905441',
    projectId: 'tiktok-kks653',
    storageBucket: 'tiktok-kks653.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuCFAm4iTyb3IIJBItLD7gbhwpuoP01B4',
    appId: '1:459258905441:ios:7f41c552560581217a3b20',
    messagingSenderId: '459258905441',
    projectId: 'tiktok-kks653',
    storageBucket: 'tiktok-kks653.appspot.com',
    iosClientId: '459258905441-ug5nc7vhrb376vfk9ik8kv6tvjb577oo.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}
