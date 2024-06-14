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
    apiKey: 'AIzaSyDTOWvzTKahNtTFICZG4bM0te4EZCj2v6A',
    appId: '1:261757654724:web:ba3058a615aa2b3debdb91',
    messagingSenderId: '261757654724',
    projectId: 'computerstatusreport',
    authDomain: 'computerstatusreport.firebaseapp.com',
    storageBucket: 'computerstatusreport.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPeC2nEC7aEYKSRR4BSmjaTzExDE3mECU',
    appId: '1:261757654724:android:db9f870ead7c30e7ebdb91',
    messagingSenderId: '261757654724',
    projectId: 'computerstatusreport',
    storageBucket: 'computerstatusreport.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAC7vS-eEbLBGrdXgBoeCQYMgk9nN8ST-g',
    appId: '1:261757654724:ios:925e8e98e9b1dca6ebdb91',
    messagingSenderId: '261757654724',
    projectId: 'computerstatusreport',
    storageBucket: 'computerstatusreport.appspot.com',
    iosBundleId: 'com.example.computerStatusReporter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAC7vS-eEbLBGrdXgBoeCQYMgk9nN8ST-g',
    appId: '1:261757654724:ios:925e8e98e9b1dca6ebdb91',
    messagingSenderId: '261757654724',
    projectId: 'computerstatusreport',
    storageBucket: 'computerstatusreport.appspot.com',
    iosBundleId: 'com.example.computerStatusReporter',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDTOWvzTKahNtTFICZG4bM0te4EZCj2v6A',
    appId: '1:261757654724:web:e2a026f91377524eebdb91',
    messagingSenderId: '261757654724',
    projectId: 'computerstatusreport',
    authDomain: 'computerstatusreport.firebaseapp.com',
    storageBucket: 'computerstatusreport.appspot.com',
  );
}