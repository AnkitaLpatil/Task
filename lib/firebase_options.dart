import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    } else {
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
          return linux;
        default:
          throw UnsupportedError('This platform is not supported');
      }
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyComUJ0lBJMyeowY3Ne3g_0p6Wdsiz2y28",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.appspot.com",
    messagingSenderId: "75903377943",
    appId: "1:75903377943:web:48d0fa8bc62ff2f8e07252"
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCuI_RxyMwK4h64n5916MtGby5f9pxmHMk",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.firebasestorage.app",
    messagingSenderId: "75903377943",
    appId: "1:75903377943:android:c896de8bb98084b0e07252"
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyChYIr-uBgvRIbfND2uJZZC7GL57EBG34s",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.appspot.com",
    messagingSenderId: "75903377943",
    appId: "1:75903377943:ios:dd1ff121903b05c5e07252"
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "YOUR_MACOS_API_KEY",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.appspot.com",
    messagingSenderId: "YOUR_MACOS_MESSAGING_SENDER_ID",
    appId: "YOUR_MACOS_APP_ID"
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "YOUR_WINDOWS_API_KEY",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.appspot.com",
    messagingSenderId: "YOUR_WINDOWS_MESSAGING_SENDER_ID",
    appId: "YOUR_WINDOWS_APP_ID"
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: "YOUR_LINUX_API_KEY",
    authDomain: "users-afe21.firebaseapp.com",
    projectId: "users-afe21",
    storageBucket: "users-afe21.appspot.com",
    messagingSenderId: "YOUR_LINUX_MESSAGING_SENDER_ID",
    appId: "YOUR_LINUX_APP_ID"
  );
}
