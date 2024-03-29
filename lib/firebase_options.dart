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
    apiKey: 'AIzaSyB6L7pgzapTkSM7Z3AoJGXURQd6GrScofw',
    appId: '1:252226548544:web:7916bdec66d7a55faa00a5',
    messagingSenderId: '252226548544',
    projectId: 'squadgather-4bb2f',
    authDomain: 'squadgather-4bb2f.firebaseapp.com',
    databaseURL: 'https://squadgather-4bb2f-default-rtdb.firebaseio.com',
    storageBucket: 'squadgather-4bb2f.appspot.com',
    measurementId: 'G-L57XHJZQ97',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuyoc009ll8enp_dZ78_BHVgt0V9AEsss',
    appId: '1:252226548544:android:f63a3478b4835bdbaa00a5',
    messagingSenderId: '252226548544',
    projectId: 'squadgather-4bb2f',
    databaseURL: 'https://squadgather-4bb2f-default-rtdb.firebaseio.com',
    storageBucket: 'squadgather-4bb2f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgfhFo96xbglGgCmbjT3kb9DGBVP8rJUw',
    appId: '1:252226548544:ios:d8a25b538f7d15ceaa00a5',
    messagingSenderId: '252226548544',
    projectId: 'squadgather-4bb2f',
    databaseURL: 'https://squadgather-4bb2f-default-rtdb.firebaseio.com',
    storageBucket: 'squadgather-4bb2f.appspot.com',
    iosBundleId: 'com.example.squadgather',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgfhFo96xbglGgCmbjT3kb9DGBVP8rJUw',
    appId: '1:252226548544:ios:f913486eac233f46aa00a5',
    messagingSenderId: '252226548544',
    projectId: 'squadgather-4bb2f',
    databaseURL: 'https://squadgather-4bb2f-default-rtdb.firebaseio.com',
    storageBucket: 'squadgather-4bb2f.appspot.com',
    iosBundleId: 'com.example.squadgather.RunnerTests',
  );
}
