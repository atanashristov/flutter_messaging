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
    apiKey: 'AIzaSyDvbZp06Dq6Az5mfiKGAhW4CWCPGMOi7V4',
    appId: '1:882967456335:web:e34ee1b2ed39793d17583a',
    messagingSenderId: '882967456335',
    projectId: 'airship-messaging-staging',
    authDomain: 'airship-messaging-staging.firebaseapp.com',
    storageBucket: 'airship-messaging-staging.appspot.com',
    measurementId: 'G-3HJFDYGECH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB67oVltoOgFKuU9YKfbyOguR27cFoQYl4',
    appId: '1:882967456335:android:b55cf9d3f575223517583a',
    messagingSenderId: '882967456335',
    projectId: 'airship-messaging-staging',
    storageBucket: 'airship-messaging-staging.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCrgCodnFWjAIg1Cc9BCOMwWARXwc787ck',
    appId: '1:882967456335:ios:83d6a860dead679317583a',
    messagingSenderId: '882967456335',
    projectId: 'airship-messaging-staging',
    storageBucket: 'airship-messaging-staging.appspot.com',
    iosClientId: '882967456335-pv0hqpm6gn8uc2h7hcm7lqb7h54j9oq1.apps.googleusercontent.com',
    iosBundleId: 'com.atanashristov.airshipMessagingStaging',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCrgCodnFWjAIg1Cc9BCOMwWARXwc787ck',
    appId: '1:882967456335:ios:49941752c607d41717583a',
    messagingSenderId: '882967456335',
    projectId: 'airship-messaging-staging',
    storageBucket: 'airship-messaging-staging.appspot.com',
    iosClientId: '882967456335-tiqefk2jvqhk1l3r1bsmve00vhbjop4j.apps.googleusercontent.com',
    iosBundleId: 'com.atanashristov.airshipMessaging',
  );
}
