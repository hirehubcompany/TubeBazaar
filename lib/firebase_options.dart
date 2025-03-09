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
    apiKey: 'AIzaSyAwG6oqV33LgWcHRGpIg7HR87r627IfqYU',
    appId: '1:440450708687:web:f8a80211c510a62b3eb3ba',
    messagingSenderId: '440450708687',
    projectId: 'tubebazaar-b9484',
    authDomain: 'tubebazaar-b9484.firebaseapp.com',
    storageBucket: 'tubebazaar-b9484.firebasestorage.app',
    measurementId: 'G-XX3VTVMFWQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeiIcx4bVNv0o-m5rA2n6VgGlFrttVZwI',
    appId: '1:440450708687:android:a1aba38d9650a14d3eb3ba',
    messagingSenderId: '440450708687',
    projectId: 'tubebazaar-b9484',
    storageBucket: 'tubebazaar-b9484.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBsgcKIAYzG9QpC4TOqYSq-oWuSzJn3_nI',
    appId: '1:440450708687:ios:85194ec892228a563eb3ba',
    messagingSenderId: '440450708687',
    projectId: 'tubebazaar-b9484',
    storageBucket: 'tubebazaar-b9484.firebasestorage.app',
    iosBundleId: 'com.tubebazaar.tubebazaar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBsgcKIAYzG9QpC4TOqYSq-oWuSzJn3_nI',
    appId: '1:440450708687:ios:85194ec892228a563eb3ba',
    messagingSenderId: '440450708687',
    projectId: 'tubebazaar-b9484',
    storageBucket: 'tubebazaar-b9484.firebasestorage.app',
    iosBundleId: 'com.tubebazaar.tubebazaar',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAwG6oqV33LgWcHRGpIg7HR87r627IfqYU',
    appId: '1:440450708687:web:72905f6959868c493eb3ba',
    messagingSenderId: '440450708687',
    projectId: 'tubebazaar-b9484',
    authDomain: 'tubebazaar-b9484.firebaseapp.com',
    storageBucket: 'tubebazaar-b9484.firebasestorage.app',
    measurementId: 'G-JGLP6D81QF',
  );
}
