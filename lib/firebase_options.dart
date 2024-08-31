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
    apiKey: 'AIzaSyArZFs9vacxpoWa8xZNcT747lqPBKoRrPw',
    appId: '1:932044794561:web:7454779127902ebf820240',
    messagingSenderId: '932044794561',
    projectId: 'finervadb',
    authDomain: 'finervadb.firebaseapp.com',
    storageBucket: 'finervadb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJFX_eeOrESkWvkJHD9YNAiWYn3q58W5g',
    appId: '1:932044794561:android:fb2dd85759b054d7820240',
    messagingSenderId: '932044794561',
    projectId: 'finervadb',
    storageBucket: 'finervadb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAt2CTfDLeOaZ0MF5wNHHYmQSFJCob4bI',
    appId: '1:932044794561:ios:54e45247171aac01820240',
    messagingSenderId: '932044794561',
    projectId: 'finervadb',
    storageBucket: 'finervadb.appspot.com',
    iosClientId: '932044794561-8g7ccir6q6o0eufdv39hn87q4v2f7j66.apps.googleusercontent.com',
    iosBundleId: 'com.example.finerva',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAt2CTfDLeOaZ0MF5wNHHYmQSFJCob4bI',
    appId: '1:932044794561:ios:54e45247171aac01820240',
    messagingSenderId: '932044794561',
    projectId: 'finervadb',
    storageBucket: 'finervadb.appspot.com',
    iosClientId: '932044794561-8g7ccir6q6o0eufdv39hn87q4v2f7j66.apps.googleusercontent.com',
    iosBundleId: 'com.example.finerva',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyArZFs9vacxpoWa8xZNcT747lqPBKoRrPw',
    appId: '1:932044794561:web:fffe5042ee626a42820240',
    messagingSenderId: '932044794561',
    projectId: 'finervadb',
    authDomain: 'finervadb.firebaseapp.com',
    storageBucket: 'finervadb.appspot.com',
  );
}
