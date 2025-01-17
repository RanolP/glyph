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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWaG3h7U3lTrylrxdsRdEaYIOKsp54wCQ',
    appId: '1:58678861052:android:a1ecff4792b696f9bd8b79',
    messagingSenderId: '58678861052',
    projectId: 'withglyph',
    storageBucket: 'withglyph.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHqPtrt1zJg25WnFB5kNEIqa2eN31kwLc',
    appId: '1:58678861052:ios:65d590f2311a51d6bd8b79',
    messagingSenderId: '58678861052',
    projectId: 'withglyph',
    storageBucket: 'withglyph.appspot.com',
    androidClientId:
        '58678861052-5l5pkmjo47h6ff86rcaiqfdfdgusd73d.apps.googleusercontent.com',
    iosClientId:
        '58678861052-cn5n72vkh4t5eafgffeqjdk2u84chrnc.apps.googleusercontent.com',
    iosBundleId: 'com.withglyph.app',
  );
}
