import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR-WEB-API-KEY',
    appId: 'YOUR-WEB-APP-ID',
    messagingSenderId: 'YOUR-SENDER-ID',
    projectId: 'YOUR-PROJECT-ID',
    authDomain: 'YOUR-AUTH-DOMAIN',
    storageBucket: 'YOUR-STORAGE-BUCKET',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQwRBR_NRBl7PJIHNaPW-i5MBPAHDSsgc',
    appId: '1:215400804398:android:a22a2e13e2bf6da4d62fbf',
    messagingSenderId: '215400804398',
    projectId: 'note-51967',
    storageBucket: 'note-51967.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBKojquxI0M1Nl11513-PIHUB2g_ztHGCI',
    appId: '1:215400804398:ios:6a429c403a37f940d62fbf',
    messagingSenderId: '215400804398',
    projectId: 'note-51967',
    storageBucket: 'note-51967.firebasestorage.app',
    androidClientId: '215400804398-ql7l4hspacv67b1j5cvhv058k5anajt2.apps.googleusercontent.com',
    iosClientId: '215400804398-t6s00t0vao29doa76bd7j8lt01efaive.apps.googleusercontent.com',
    iosBundleId: 'com.example.myDiary',
  );

} 