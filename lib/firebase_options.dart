// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'firebase_keys.dart'; // Import FirebaseKeys

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseKeys.web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseKeys.android;
      case TargetPlatform.iOS:
        return FirebaseKeys.ios;
      case TargetPlatform.macOS:
        return FirebaseKeys.macos;
      case TargetPlatform.windows:
        return FirebaseKeys.windows;
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
}
