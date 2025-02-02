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
    apiKey: 'AIzaSyAfsf_DrtdsHSQcSX098uxSxpdjaisYcts',
    appId: '1:343865819084:web:26cfeac36bc8552e516769',
    messagingSenderId: '343865819084',
    projectId: 'ai-based-wild-animal-detection',
    authDomain: 'ai-based-wild-animal-detection.firebaseapp.com',
    storageBucket: 'ai-based-wild-animal-detection.firebasestorage.app',
    measurementId: 'G-926X522YL2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmUAaIBphRzQQ-xnFGqPO9jgOw5S6mIJw',
    appId: '1:343865819084:android:b41c07fe365bd0b9516769',
    messagingSenderId: '343865819084',
    projectId: 'ai-based-wild-animal-detection',
    storageBucket: 'ai-based-wild-animal-detection.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBL-rfQRB0LlHTHaZjo39JB1LyAhwhWSAs',
    appId: '1:343865819084:ios:0bc9dff0cfec98b7516769',
    messagingSenderId: '343865819084',
    projectId: 'ai-based-wild-animal-detection',
    storageBucket: 'ai-based-wild-animal-detection.firebasestorage.app',
    iosBundleId: 'com.example.wads',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBL-rfQRB0LlHTHaZjo39JB1LyAhwhWSAs',
    appId: '1:343865819084:ios:0bc9dff0cfec98b7516769',
    messagingSenderId: '343865819084',
    projectId: 'ai-based-wild-animal-detection',
    storageBucket: 'ai-based-wild-animal-detection.firebasestorage.app',
    iosBundleId: 'com.example.wads',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAfsf_DrtdsHSQcSX098uxSxpdjaisYcts',
    appId: '1:343865819084:web:9ea497baf64a1878516769',
    messagingSenderId: '343865819084',
    projectId: 'ai-based-wild-animal-detection',
    authDomain: 'ai-based-wild-animal-detection.firebaseapp.com',
    storageBucket: 'ai-based-wild-animal-detection.firebasestorage.app',
    measurementId: 'G-9NQZ2QE579',
  );
}
