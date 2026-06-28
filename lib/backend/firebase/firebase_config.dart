import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyAJeWHKrBk964zSJMyGkxSpF_u9l846jXg",
            authDomain: "managmentofsportarea-gy07t6.firebaseapp.com",
            projectId: "managmentofsportarea-gy07t6",
            storageBucket: "managmentofsportarea-gy07t6.firebasestorage.app",
            messagingSenderId: "413972269602",
            appId: "1:413972269602:web:cb08b42a33a9e0138f187b"));
  } else {
    await Firebase.initializeApp();
  }
}
